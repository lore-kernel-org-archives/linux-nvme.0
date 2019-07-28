From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 12:18:22 +0900
Subject: [PATCH V2 2/3] lnvm: introduce chunk-log command for chunk info
In-Reply-To: <8276ea2a-990d-3aae-b144-54986153e834@lightnvm.io>
References: <20190727193249.22655-1-minwoo.im.dev@gmail.com>
 <20190727193249.22655-3-minwoo.im.dev@gmail.com>
 <8276ea2a-990d-3aae-b144-54986153e834@lightnvm.io>
Message-ID: <20190728031822.GC24390@minwoo-desktop>

Hi Matias,

> > +static inline const char *print_chunk_type(__u8 ct)
> > +{
> > +	switch (ct) {
> > +	case 1 << 0:	return "SEQWRITE_REQ";
> > +	case 1 << 1:	return "RANDWRITE_ALLOWED";
> > +	case 1 << 4:	return "DEVIATED";
> > +	default:	return "UNKNOWN";
> > +	}
> > +}
> 
> The Chunk Type is divided into two value ranges - one for the chunk type
> (seq, req) and one that describes the properties of the zone. I would move
> the "Deviated" into being expressed as an attribute (or similar). Then they
> are clearly separated. An OCSSD implementation can both have the SEQ write
> bit set, together with bit 4 for dynamic chunk capacity. The above doesn't
> communicate that in the right way.

Ah sorry, I think my brain was not working well in the dawn ;).  I'll
provide "Deviated" things as an attribute first regardless the chunk
types.

Thanks for the review.  Will prepare the next version.
