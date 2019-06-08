From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 8 Jun 2019 10:37:01 +0900
Subject: [RFC PATCH V7 4/7] nvme: trace: support for fabrics commands in
 host-side
In-Reply-To: <20190607165156.GG7307@lst.de>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
 <20190606194512.11020-5-minwoo.im.dev@gmail.com>
 <20190607165156.GG7307@lst.de>
Message-ID: <20190608013701.GD1276@minwooim-desktop>

On 19-06-07 18:51:56, Christoph Hellwig wrote:
> 
> > +#define parse_nvme_cmd(qid, opcode, fctype, cdw10)			\
> > +	((opcode != nvme_fabrics_command) ?				\
> > +		(qid ?							\
> > +			nvme_trace_parse_nvm_cmd(p, opcode, cdw10) :	\
> > +			nvme_trace_parse_admin_cmd(p, opcode, cdw10)) :	\
> > +		nvme_trace_parse_fabrics_cmd(p, fctype, cdw10))
> 
> The indentation and use of braces looks a little odd here, how about:
> 
> #define parse_nvme_cmd(qid, opcode, fctype, cdw10)		\
> 	((opcode) == nvme_fabrics_command ?			\
> 	 nvme_trace_parse_fabrics_cmd(p, fctype, cdw10) :	\
> 	((qid) ?						\
> 	 nvme_trace_parse_nvm_cmd(p, opcode, cdw10) :	\
> 	 nvme_trace_parse_admin_cmd(p, opcode, cdw10)))
> 
> 
> > +/*
> > + * If not fabrics command, fctype will be ignored.
> > + */
> > +#define show_opcode_name(qid, opcode, fctype)			\
> > +	((opcode != nvme_fabrics_command) ?			\
> > +		(qid ?						\
> > +			show_nvm_opcode_name(opcode) :		\
> > +			show_admin_opcode_name(opcode)) :	\
> > +		show_fabrics_type_name(fctype))
> > +
> 
> and:
> 
> #define show_opcode_name(qid, opcode, fctype)	\
> 	((opcode) == nvme_fabrics_command ?	\
> 	 show_fabrics_type_name(fctype) :	\
> 	((qid) ?				\
> 	 show_nvm_opcode_name(opcode) :		\
> 	 show_admin_opcode_name(opcode)))

I'm actually fine with both.  I was trying to make some depth from the
previous comparisons. But, Okay, will fix this up in next series.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Thanks for your review, Christoph.

Thanks,
