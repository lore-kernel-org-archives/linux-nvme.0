From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Jan 2015 18:02:04 +0000 (UTC)
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO command
 is being issued via a block device file descriptor
In-Reply-To: <20150125145900.GA15231@infradead.org>
References: <1422057426-8014-1-git-send-email-yan@purestorage.com>
 <20150125145900.GA15231@infradead.org>
Message-ID: <alpine.LNX.2.00.1501261635190.15481@localhost.lm.intel.com>

On Sun, 25 Jan 2015, Christoph Hellwig wrote:
> On Fri, Jan 23, 2015@03:57:06PM -0800, Yan Liu wrote:
>> When a passthrough IO command is issued with a specific block device file descriptor. It should be applied at
>> the namespace which is associated with that block device file descriptor. This patch makes such passthrough
>> command ignore nsid in nvme_passthru_cmd structure. Instead it takes the namespace ID asscoiated with the
>> block device descriptor.
>
> This looks good to me.  If Keith can point to a use case for magic or
> hidden nsids we'll have to find a bypass for them, but this certainly
> is the right short term fix:

'Flush' is the only command from the spec where specifying all namespaces
might be desirable. Otherwise, I can't disclose vendor specific behavior
to gain concensus on operating within spec, silly as this desire may
seem. Why empower the driver to make a feature unreachable?
