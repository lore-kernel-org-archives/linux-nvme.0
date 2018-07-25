From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 25 Jul 2018 06:43:27 +0000
Subject: [PATCH 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180725045352.GA10905@lst.de>
References: <20180725001316.2714-1-chaitanya.kulkarni@wdc.com>,
 <20180725045352.GA10905@lst.de>
Message-ID: <BYAPR04MB450296FC5D750613D0290D0986540@BYAPR04MB4502.namprd04.prod.outlook.com>


From: Christoph Hellwig <hch@lst.de>
Sent: Tuesday, July 24, 2018 9:53 PM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; hch at lst.de; keith.busch at intel.com
Subject: Re: [PATCH 1/2] nvme-cli: add minimal ana-log page support
? 
 
On Tue, Jul 24, 2018@05:13:15PM -0700, Chaitanya Kulkarni wrote:
> This patch adds a new command to retrieve the ANA Log page.
> We update identify ctrl/ns data structure to support this command.
> We also add ana based error codes and different identifiers to the
> linux/nvme.h header file in order to support this command.

One thing I am a little concerned about here is that reading the
ANA log page may clear the ANA AEN.? This actually is the same for
other log pages that clear AENs, but for ANA the effects are much
worse.

Keith, wat do you think of always setting the RAE bit for log pages
associated with AENs?? The only real issue I can see is that the
bit is only defined for NVMe 1.3+ so we'd need to figure out the
version somehow.? Maybe with a new ioctl so that we don't have
to send an identify every time.

We also really need the RAE bit implemented in the Linux target.
This should be very simple but I haven't got to it yet.? Chaitanya,
do you want to give it a quick spin independent of this discussion?

[CK] Yes.

And now some comments on the patch itself:

> +const char * nvme_ana_state_to_string(int state)

No space after the '*', please.? Also the type of state should be
'enum nvme_ana_state'.

> +{
> +???? switch (state) {
> +???? case NVME_ANA_OPTIMIZED:
> +???????????? return "OPTIMIZED";
> +???? case NVME_ANA_NONOPTIMIZED:
> +???????????? return "NON-OPTIMIZED";
> +???? case NVME_ANA_INACCESSIBLE:
> +???????????? return "INACCESSIBLE";
> +???? case NVME_ANA_PERSISTENT_LOSS:
> +???????????? return "PERSISTENT-LOSS";
> +???? case NVME_ANA_CHANGE:
> +???????????? return "CHANGE";
> +???? default:
> +???????????? return "UNKNOWN";
> +???? }
> +}

Is there precedene for SHOUTING elsewhere in nvme-clu?? Otherwise I'd
suggest to print these in lower case and match what is in the kernel
sysfs files.

> +void show_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname)

The devname argument seems unused.

> +{
> +???? int offset = sizeof(struct nvme_ana_rsp_hdr);
> +???? void *base = ana_log;
> +???? struct nvme_ana_rsp_hdr *hdr = base;
> +???? struct nvme_ana_group_desc *desc;
> +???? size_t nsid_buf_size;
> +???? __u32 nr_nsids;
> +???? int i;
> +???? int j;
> +
> +???? printf("ANA LOG HEADER :-\n");
> +???? printf("chgcnt? :?????? %"PRIu64"\n", (uint64_t)le64_to_cpu(hdr->chgcnt));
> +???? printf("ngrps?? :?????? %u\n", le16_to_cpu(hdr->ngrps));
> +???? printf("ANA Log Desc :-\n");
> +
> +???? for (i = 0; i < le16_to_cpu(ana_log->ngrps); i++) {
> +???????????? desc = base + offset;
> +???????????? nr_nsids = le32_to_cpu(desc->nnsids);
> +???????????? nsid_buf_size = nr_nsids * sizeof(__le32);
> +
> +???????????? offset += sizeof(*desc);
> +???????????? printf("grpid?? :?????? %u\n", le32_to_cpu(desc->grpid));
> +???????????? printf("nnsids? :?????? %u\n", le32_to_cpu(desc->nnsids));
> +???????????? printf("chgcnt? :?????? %llu\n", le64_to_cpu(desc->chgcnt));
> +???????????? printf("state?? :?????? %s\n", nvme_ana_state_to_string(desc->state));

I think we also need a json version of all this, don't we?

[CK] Yes, we also need a binary mode to be compatible with other log commands,
I'll add both it in the next version.

> +static int get_ana_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)

Overly long line.

[CK] Thanks for the comments, I'll fix all these in the next version.



    
