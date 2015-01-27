From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Jan 2015 22:09:35 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <1422395867952.40819@hgst.com>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
Message-ID: <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>

On Tue, 27 Jan 2015, David Darrington wrote:
> What happens if a namespace includes metadata that is not interleaved (flbas
> bit 4 = 0)? Won't the reads/writes through the normal block io path cause
> metadata to be read/written to/from MPTR, which is not set in
> nvme_submit_iod() so will point to address 0.

You're absolutely right. I'm not sure what happens (I don't have a device
with separate metadata capabilities) but was hoping the device wouldn't
try to DMA to/from 0, or it would be aborted by the root complex if it
made it that far. Wishful thinking, probably not aligned with reality.

The nvme_submit_io() path enforces correct MPTR usage, though!
