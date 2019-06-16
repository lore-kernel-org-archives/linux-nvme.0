From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 16 Jun 2019 13:51:37 +0900
Subject: [PATCH 2/3] nvme-pci: remove queue_count_ops for write,poll_queues
In-Reply-To: <20190610035219epcms2p152ffea1ffdda63bba9a901dd42979a11@epcms2p1>
References: <CACVXFVPm4v1-9Sta3C0oN3YdTQhGQL1EVDwPBmA4i28SMHJAaQ@mail.gmail.com>
 <20190610015155.GD26551@ming.t460p>
 <20190608180219.17523-1-minwoo.im.dev@gmail.com>
 <20190608180219.17523-3-minwoo.im.dev@gmail.com>
 <20190610022522epcms2p26bc1b339680476ac6d81050045545f44@epcms2p2>
 <20190610024127.GE26551@ming.t460p>
 <20190610034136epcms2p1981531bd319a5210167e26251c5a6a4b@epcms2p1>
 <CGME20190610015241epcas3p2a021735345864364cb7f8c6aded4685d@epcms2p1>
 <20190610035219epcms2p152ffea1ffdda63bba9a901dd42979a11@epcms2p1>
Message-ID: <20190616045137.GA5373@minwooim-desktop>

On 19-06-10 12:52:19, Minwoo Im wrote:
> 
> > > > > > However, the check is valid, which shouldn't be nop, so could you fix
> > > > > > the check instead of removing it?
> > > > >
> > > > > Hi, Ming.
> > > > >
> > > > > I don't get what you really mean here.   What do you mean "the check is
> > > > > valid"? I don't see any valid checks in queue_count_set(), not just for
> > > > > check for the failure by kstrtoint().  I think current code is just checks
> > > > > the nr_cpus and do nothing after.
> > > > >
> > > > > Instead fixing this check inside of this function, I have posted the next
> > > > > patch in this series to make sure the number of irqs requested not
> > > > > exceed the num_possible_num().
> > > >
> > > > I suggest to cap 'write_queues' or 'poll_writes' to num_possible_num()
> > > > from the beginning, instead of starting with invalid number.
> > >
> > > Ming,
> > >
> > > Thanks for your review :)
> > >
> > > I have already tried to limit the number of queues inside of
> > queue_count_set()
> > > in [1].  But Christoph had suggested to limit the number in
> > nvme_calc_irq_sets()
> > > instead.  It might be my code was not really good at that time, but could
> > you
> > > please have a look at the mail thread below and give some advices for me?
> > >
> > > [1]  http://lists.infradead.org/pipermail/linux-nvme/2019-May/023868.html
> > 
> > Sorry for missing the previous discussion.
> > 
> > IMO, I prefer to the fix in above link. Cause it is the value of
> > kernel_param_ops
> > to make 'write_queue/poll_queue'  correct from the beginning. That is just
> > like OOP's concept in which each method just does one thing. Then we don't
> > need to bother nvme_calc_irq_sets() for verifying/fixing them.
> 
> Christoph,
> 
> What do you think about what Ming's suggested?  I am actually okay with the
> concept that the function just does its own things.
> 
> It would be great if you can give some advices here :)
> 
> Thanks,

(Gentle ping)

Hi Christoph,

Could you please take a look at this patch ?

Thanks,
