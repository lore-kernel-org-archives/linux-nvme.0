From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 18 Jun 2018 15:57:01 -0600
Subject: [PATCH] nvme-cli: Implemented primary and secondary controller
In-Reply-To: <20180618212814.9273-1-revanth.rajashekar@intel.com>
References: <20180618212814.9273-1-revanth.rajashekar@intel.com>
Message-ID: <20180618215701.GA19922@localhost.localdomain>

On Mon, Jun 18, 2018@03:28:14PM -0600, Revanth Rajashekar wrote:
>  	NVME_ID_CNS_NS_PRESENT		= 0x11,
>  	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
>  	NVME_ID_CNS_CTRL_LIST		= 0x13,
> +	NVME_ID_CNS_PIMARY_CNTRLR_CAP 		= 0x14,
> +	NVME_ID_CNS_SECONDARY_CNTRLR_LIST 	= 0x15,

Let's stick with the existing convention of "CTRL" as the abbreviation
for controller.

> +	ENTRY("primary-cntrlr", "Obtain the primary controller capabilities structure", primary_cntrlr)
> +	ENTRY("secondary-cntrlr", "Obtain a Secondary Controller list associated with the primary controller", secondary_cntrlr)


Similarly, controller is abbreviated as "ctrl" by existing convention,
and different types of identify commands are prefixed with "id-".

> +int nvme_cntrlr13(int fd, __u32 cdw10, __u32 cdw11, void *data)
> +{
> +	struct nvme_admin_cmd cmd = {
> +		.opcode 	= nvme_admin_virtual_mgmt,
> +		.nsid		= 0,
> +		.addr 		= (__u64)(uintptr_t) data,
> +		.data_len	= NVME_VIRTUAL_CNTRLR_DATA_SIZE,
> +		.cdw10 		= cdw10,
> +		.cdw11 		= cdw11,
> +	};
> +
> +	return nvme_submit_admin_passthru(fd, &cmd);
> +}

I can't tell what this function is for or why it's named with a "13"
suffix. Also CDW11 isn't used for identify commands.

> +void show_nvme_primary_cntrlr_crt(__u8 crt)
> +{
> +	__u8 rsvd = (crt & 0xFC) >> 2;
> +	__u8 vir  = (crt & 0x2) >> 1;
> +	__u8 vqr  = crt & 0x1;
> +	if (rsvd)
> +		printf("  [7:2] : %#x\tReserved\n", rsvd);
> +	printf("  [1:1] : %#x\t VI Resources are %s\n",
> +		vir, vir ? "Supported" : "NOT Supported");
> +	printf("  [0:0] : %#x\t VQ Resources are %s\n", vqr,
> +		vqr ? "Supported" : "NOT Supported");
> +	printf("\n");
> +}

I don't think you want to call this without the "human readable"
option, right?

> +void show_nvme_primary_cntrlr(struct nvme_id_primary_cntrlr *ctrl)
> +{
> +	printf("cntlid     : %#x\n", le16_to_cpu(ctrl->cntlid));
> +	printf("portid     : %#x\n", le16_to_cpu(ctrl->portid));
> +	printf("crt        : %#x\n", ctrl->crt);
> +	show_nvme_primary_cntrlr_crt(ctrl->crt);
> +	printf("vqfrt      : %d\n", ctrl->vqfrt);
> +	printf("vqrfa      : %d\n", ctrl->vqrfa);

le32_to_cpu on the above two prints.

> +void show_nvme_secondary_cntrlr_entry_scs(__u8 scs)
> +{
> +	__u8 rsvd = (scs & 0xFE) >> 1;
> +	__u8 os  = scs & 0x1;
> +
> +	if (rsvd)
> +		printf("  [7:1] : %#x\tReserved\n", rsvd);
> +	printf("  [0:0] : %#x\t Controller is in %s state\n", os,
> +		os ? "Online" : "Offline");
> +
> +}

Another function that looks like it should not be called without the
"human readable" option.

> +void show_nvme_secondary_cntrlr_entry(struct nvme_secondary_cntrlr_entry *ctrl)
> +{
> +	printf("scid     : %#x\n", le16_to_cpu(ctrl->scid));
> +	printf("pcid     : %#x\n", le16_to_cpu(ctrl->pcid));
> +	printf("scs 	 : %#x\n",ctrl->scs);
> +	show_nvme_secondary_cntrlr_entry_scs(ctrl->scs);
> +	printf("vfn	     : %d\n", le16_to_cpu(ctrl->vfn));
> +	printf("nvq	     : %d\n", le16_to_cpu(ctrl->nvq));
> +	printf("nvi	     : %d\n", le16_to_cpu(ctrl->nvi));
> +}
> +
> +void show_nvme_secondary_cntrlr_list(struct nvme_secondary_cntrlr_list *ctrl)
> +{
> +	int i;
> +
> +	printf("num_of_identifiers  : %d\n", ctrl->num_of_identifiers);
> +	for(i = 0; i < ctrl->num_of_identifiers; i++)
> +		show_nvme_secondary_cntrlr_entry(&ctrl->sc[i]);
> +}

We need a print here to break up different controllers in this list.

> +void json_nvme_primary_cntrlr(struct nvme_id_primary_cntrlr *ctrl)
> +{
> +	struct json_object *root;
> +	root = json_create_object();
> +
> +	json_object_add_value_int(root, "cntlid", le16_to_cpu(ctrl->cntlid));
> +	json_object_add_value_int(root, "portid", le16_to_cpu(ctrl->portid));
> +	json_object_add_value_int(root, "crt", ctrl->crt);
> +	json_object_add_value_int(root, "vqfrt", ctrl->vqfrt);
> +	json_object_add_value_int(root, "vqrfa", ctrl->vqrfa);

le32_to_cpu on the above two.

> +int primary_cntrlr(int argc, char **argv, struct command *cmd, struct plugin *plugin)
> +{
> +	const char *desc = "Send an Primary Controller command to "\
> +		"the given device and report information about the specified "\
> +		"primary controller in human-readable or binary format.";
> +	const char *raw_binary = "show infos in binary format";
> +	const char *human_readable = "show infos in readable format";
> +	int err, fmt, fd;
> +	struct nvme_id_primary_cntrlr ctrl;
> +
> +	struct config {
> +		int raw_binary;
> +		int human_readable;
> +		char *output_format;
> +	};
> +
> +	struct config cfg = {
> +		.output_format = "normal",
> +	};
> +
> +	const struct argconfig_commandline_options command_line_options[] = {
> +		{"raw-binary",      'b', "",    CFG_NONE,   &cfg.raw_binary,      no_argument,       raw_binary},
> +		{"human-readable",  'H', "",    CFG_NONE,   &cfg.human_readable,  no_argument,       human_readable},
> +		{"output-format",   'o', "FMT", CFG_STRING, &cfg.output_format,   required_argument, output_format },
> +		{NULL}

Let's not use the binary option when we have the "output-format" option.
That binary option is really a legacy carry-over from when we only had
the two possible options.

Also, I don't think the "human-readable" option is particularly well
named anymore. The "normal" output option already is human readable, but
the additional "human-readable" option really just means to be more
"verbose", so I would favor seeing any new commands that have such
potential for additional verbosity in its decoding use a "--verbose" or
"-v" option instead.
