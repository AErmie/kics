package Cx

import data.generic.common as common_lib

#pods
CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") == "Pod"

	metadata := document.metadata
	common_lib.valid_key(metadata, "annotations")

	annotations := metadata.annotations
	not common_lib.valid_key(annotations, "seccomp.security.alpha.kubernetes.io/defaultProfileName")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name=%s", [metadata.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is set",
		"keyActualValue": "'metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is undefined",
	}
}

CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") == "Pod"

	metadata := document.metadata
	common_lib.valid_key(metadata, "annotations")
	annotations := metadata.annotations

	common_lib.valid_key(annotations, "seccomp.security.alpha.kubernetes.io/defaultProfileName")

	seccomp := annotations["seccomp.security.alpha.kubernetes.io/defaultProfileName"]

	seccomp != "runtime/default"

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name=%s", [metadata.name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is 'runtime/default'",
		"keyActualValue": sprintf("'metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is '%s'", [seccomp]),
	}
}

CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") == "Pod"

	metadata := document.metadata
	not common_lib.valid_key(metadata, "annotations")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name=%s", [metadata.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'metadata.annotations' is set",
		"keyActualValue": "'metadata.annotations' is undefined",
	}
}

###################################################################

#cronjob
CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") == "CronJob"

	metadata := document.spec.jobTemplate.spec.template.metadata

	parentMetadata := document.metadata
	not common_lib.valid_key(metadata, "annotations")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name={{%s}}.spec.jobTemplate.spec.template.metadata", [parentMetadata.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'spec.jobTemplate.spec.template.metadata.annotations' is set",
		"keyActualValue": "'spec.jobTemplate.spec.template.metadata.annotations' is undefined",
	}
}

CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") == "CronJob"

	metadata := document.spec.jobTemplate.spec.template.metadata

	parentMetadata := document.metadata
	common_lib.valid_key(metadata, "annotations")

	annotations := metadata.annotations
	not common_lib.valid_key(annotations, "seccomp.security.alpha.kubernetes.io/defaultProfileName")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name={{%s}}.spec.jobTemplate.spec.template.metadata.annotations", [parentMetadata.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "spec.jobTemplate.spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is set",
		"keyActualValue": "'spec.jobTemplate.spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is undefined",
	}
}

CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") == "CronJob"

	metadata := document.spec.jobTemplate.spec.template.metadata

	parentMetadata := document.metadata
	common_lib.valid_key(metadata, "annotations")
	annotations := metadata.annotations

	common_lib.valid_key(annotations, "seccomp.security.alpha.kubernetes.io/defaultProfileName")

	seccomp := annotations["seccomp.security.alpha.kubernetes.io/defaultProfileName"]

	seccomp != "runtime/default"

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name={{%s}}.spec.jobTemplate.spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName", [parentMetadata.name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'spec.jobTemplate.spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is 'runtime/default'",
		"keyActualValue": sprintf("'spec.jobTemplate.spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is '%s'", [seccomp]),
	}
}

###################################################################

#general
CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") != "Pod"
	object.get(document, "kind", "undefined") != "CronJob"

	metadata := document.spec.template.metadata

	parentMetadata := document.metadata
	not common_lib.valid_key(metadata, "annotations")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name={{%s}}.spec.template.metadata", [parentMetadata.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'spec.template.metadata.annotations' is set",
		"keyActualValue": "'spec.template.metadata.annotations' is undefined",
	}
}

CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") != "Pod"
	object.get(document, "kind", "undefined") != "CronJob"

	metadata := document.spec.template.metadata

	parentMetadata := document.metadata
	common_lib.valid_key(metadata, "annotations")

	annotations := metadata.annotations
	not common_lib.valid_key(annotations, "seccomp.security.alpha.kubernetes.io/defaultProfileName")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name={{%s}}.spec.template.metadata.annotations", [parentMetadata.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is set",
		"keyActualValue": "'spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is undefined",
	}
}

CxPolicy[result] {
	document := input.document[i]
	object.get(document, "kind", "undefined") != "Pod"
	object.get(document, "kind", "undefined") != "CronJob"

	metadata := document.spec.template.metadata

	parentMetadata := document.metadata
	common_lib.valid_key(metadata, "annotations")
	annotations := metadata.annotations

	common_lib.valid_key(annotations, "seccomp.security.alpha.kubernetes.io/defaultProfileName")

	seccomp := annotations["seccomp.security.alpha.kubernetes.io/defaultProfileName"]

	seccomp != "runtime/default"

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("metadata.name={{%s}}.spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName", [parentMetadata.name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is 'runtime/default'",
		"keyActualValue": sprintf("'spec.template.metadata.annotations.seccomp.security.alpha.kubernetes.io/defaultProfileName' is '%s'", [seccomp]),
	}
}
