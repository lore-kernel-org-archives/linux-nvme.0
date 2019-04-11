From: minwoo.im@samsung.com (Minwoo Im)
Date: Fri, 12 Apr 2019 06:15:57 +0900
Subject: Potential bug in queue_count_set
In-Reply-To: <236178b1-7c56-1627-eed5-26706c60f71f@gmail.com>
References: <236178b1-7c56-1627-eed5-26706c60f71f@gmail.com>
 <b62dde65-1abf-1391-9de6-9bcdf6a7fa07@gmail.com>
 <d945096a-14d8-6d9f-187f-39501dfdb600@gmail.com>
 <b0d01a14-f80c-30f2-b190-d0bbe8eb6005@gmail.com>
 <CGME20190411174002epcas5p17add356b147c8c3186d7e98e411974ea@epcms2p7>
Message-ID: <20190411211557epcms2p7d5520c5762786ac4357bead574660bf6@epcms2p7>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Maximilian Luz
> Sent: Friday, April 12, 2019 2:40 AM
> To: Minwoo Im; Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: Potential bug in queue_count_set
> 
> 
> 
> >>>
> >>> It looks like lines 154, 155 don't achieve anything as `n` is not
> being
> >>> used afterwards. Sorry if this is already known or a non-issue, just
> >>> wanted to let you guys know.
> >>>
> >>
> >> It looks like module parameter "write_queues" is set to the actual
> given
> >> value (val) without considering reduced number of queues in case given
> >> value is greater than nr_cpus.
> >>
> >> I think that might need sprintf() or something like this to make the
> >> actual value reduced in that case.
> >
> >
> > Sorry, the "val" is const so that we cannot go through it with sprintf().
> > My bad.  This function might return an error if invalid number is given.
> >
> > Sorry for the confusion.
> >
> > Have posted patches for it.
> >    http://lists.infradead.org/pipermail/linux-nvme/2019-April/023369.html
> 
> I honestly know too little about module-parameters to give a qualified
> answer here, but could returning -EINVAL here break things?
> 
>  From what I can tell it should be possible to bypass the param_set_int
> function and set *(kp->arg) directly, which would reproduce the
> param_set_int functionality (kernel/params.c:223).

Got what you concern about.  We can make kp->arg have string from "n". But
Anyway we have to give "val" which might be meaningless to param_set_int()
even we modified kp->arg.

> 
> Alternatively one could argue that after a successful kstrtoint call, we
> can strncpy the input into a buffer with fixed length of 11 (10 digits +
> null, if I'm not mistaken) and use that as input for param_set_int.

Right. We can prepare a local buffer to receive the input numeric string.
But I'm not pretty sure what was the intention of Jens's commit 3b6592f70.
I think I need to have a discussion about it, If user gives more than
nr_possible_cpus, then:
  - It should be reduced to a possible value by automatically without
     any error.
  - It should return an error to let user know.

Let's see how they think about it. Also we can have a discussion on that
PATCH mail-loop.

Thanks,
		Minwoo Im
