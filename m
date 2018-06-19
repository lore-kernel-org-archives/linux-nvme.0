From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 19 Jun 2018 13:48:02 -0600
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
In-Reply-To: <CAPrnrPBKcYUsuQ6krkcjB6BOzLcPz47vje4qjic5Xw9PQN3pTQ@mail.gmail.com>
References: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
 <e75d7829-9aeb-90fb-249a-c7ac4cef10bd@intel.com>
 <CAPrnrPBKcYUsuQ6krkcjB6BOzLcPz47vje4qjic5Xw9PQN3pTQ@mail.gmail.com>
Message-ID: <20180619194802.GF19922@localhost.localdomain>

On Tue, Jun 19, 2018@10:02:17PM +0300, Eyal BenDavid wrote:
> Are the result field in struct nvme_admin_passthru and struct
> nvme_completion the same?
> I mean does ioctl copy the result field from completion to
> admin_passthru structure?

Yeah, those two are reporting the same thing. bytes 0-3 of the CQE.
The ioctl uapi was developed when the CQE bytes 4-7 were reserved in the
specification (they still are in the base spec), so those bytes were not
reported. If this is something we need to support, I think the only way
is to introduce a version-2 of the ioctl that copies the 8-byte status
for fabrics.
