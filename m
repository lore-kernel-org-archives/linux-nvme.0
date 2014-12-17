From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 17 Dec 2014 09:46:31 -0500
Subject: [PATCHv2] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <alpine.LNX.2.00.1412161613300.4026@localhost.lm.intel.com>
References: <1417738406-517-1-git-send-email-keith.busch@intel.com>
 <1417738406-517-2-git-send-email-keith.busch@intel.com>
 <20141216155552.GF2220@wil.cx>
 <alpine.LNX.2.00.1412161613300.4026@localhost.lm.intel.com>
Message-ID: <20141217144631.GG2220@wil.cx>

On Tue, Dec 16, 2014@04:39:01PM +0000, Keith Busch wrote:
> >We have an EUI64, but we're trying to return an NAA descriptor ... why not
> >just return an EUI64 descriptor instead?  ie:
> >
> >inq_response[5] = 0x02;
> >And then we don't need to muck around with the ieee[] array at all,
> >and can just copy the EUI64 into inq_response ... right?
> 
> That makes more sense, so I'll send a v3 of this patch. The translation
> spec does not provide EUI as a valid translation, so I'll send a proposal
> to the sub-committee as well.

*sigh*.  It was supposed to.

> Could you clarify something from specifications so I get this right on
> the next revision? The EUI64 was an 'M' field in 1.1, but 'O' in 1.2. I
> read the spec to require a 1.2 device use either EUI64 or NGUID but not
> both. For 1.1, I think I can assume EUI64 is okay. Would it be sufficient
> for 1.2 to memcmp() the fields with a zero'ed buffer to know which one
> the namespace implements? Or is it possible that neither is implemented
> and I have to fall back to the SCSI name string designator type?

The namespace is supposed to support at least one; the idea is that drives
with fixed namespaces use EUI64, drives which dynammically allocate
namespaces use NGUID.  Rather than doing memcmp(), can I suggest using
bitmap_empty() to determine if the EUI64 is all zeroes?

> Now that I'm looking at the name string type again, the translation looks
> broken for 1.0 devices: SPC-4 says the first for bytes are either 'eui.',
> 'naa.' or 'iqn.', but the translation has it as the UTF-8 representation
> of the vendor ID.

That sounds like a questoin for the spec wranglers :-(
