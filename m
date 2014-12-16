From: keith.busch@intel.com (Keith Busch)
Date: Tue, 16 Dec 2014 16:39:01 +0000 (UTC)
Subject: [PATCHv2] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <20141216155552.GF2220@wil.cx>
References: <1417738406-517-1-git-send-email-keith.busch@intel.com>
 <1417738406-517-2-git-send-email-keith.busch@intel.com>
 <20141216155552.GF2220@wil.cx>
Message-ID: <alpine.LNX.2.00.1412161613300.4026@localhost.lm.intel.com>

On Tue, 16 Dec 2014, Matthew Wilcox wrote:
> On Thu, Dec 04, 2014@05:13:26PM -0700, Keith Busch wrote:
>> +		/* 1.1 requires EUI64 */
>> +		struct nvme_id_ns *id_ns = mem;
>> +		u8 ieee[4];
>> +
>> +		nvme_sc = nvme_identify(dev, ns->ns_id, 0, dma_addr);
>> +		res = nvme_trans_status_code(hdr, nvme_sc);
>> +		if (res)
>> +			goto out_free;
>> +		if (nvme_sc) {
>> +			res = nvme_sc;
>> +			goto out_free;
>> +		}
>> +
>> +		/* Since SCSI tried to save 4 bits... [SPC-4(r34) Table 591] */
>> +		ieee[0] = id_ctrl->ieee[0] << 4;
>> +		ieee[1] = id_ctrl->ieee[0] >> 4 | id_ctrl->ieee[1] << 4;
>> +		ieee[2] = id_ctrl->ieee[1] >> 4 | id_ctrl->ieee[2] << 4;
>> +		ieee[3] = id_ctrl->ieee[2] >> 4;
>> +
>> +		inq_response[3] = 0x14;    /* Page Length */
>> +		/* Designation Descriptor start */
>> +		inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
>> +		inq_response[5] = 0x03;    /* PIV=0b | Asso=00b | Designator Type=3h */
>
> We have an EUI64, but we're trying to return an NAA descriptor ... why not
> just return an EUI64 descriptor instead?  ie:
>
> inq_response[5] = 0x02;
> And then we don't need to muck around with the ieee[] array at all,
> and can just copy the EUI64 into inq_response ... right?

That makes more sense, so I'll send a v3 of this patch. The translation
spec does not provide EUI as a valid translation, so I'll send a proposal
to the sub-committee as well.

Could you clarify something from specifications so I get this right on
the next revision? The EUI64 was an 'M' field in 1.1, but 'O' in 1.2. I
read the spec to require a 1.2 device use either EUI64 or NGUID but not
both. For 1.1, I think I can assume EUI64 is okay. Would it be sufficient
for 1.2 to memcmp() the fields with a zero'ed buffer to know which one
the namespace implements? Or is it possible that neither is implemented
and I have to fall back to the SCSI name string designator type?

Now that I'm looking at the name string type again, the translation looks
broken for 1.0 devices: SPC-4 says the first for bytes are either 'eui.',
'naa.' or 'iqn.', but the translation has it as the UTF-8 representation
of the vendor ID.

>> +		inq_response[6] = 0x03;    /* Rsvd */
>
> ... should be 0 since it's reserved, right?

right.
