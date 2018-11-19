From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 15:14:44 -0800
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181119.145343.2254073323355763213.davem@davemloft.net>
References: <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
 <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
 <20181119.145343.2254073323355763213.davem@davemloft.net>
Message-ID: <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>


>> I would love you to look at skb_copy_and_hash_datagram_iter as these
>> changes will require an ack from you.
> 
> My first impression is that we now have this kind of code pattern
> in at least two main places and now this will be a third.
> 
> I know that nobody likes callbacks because of spectre, but all of
> these cases could be done with something like:
> 
> int __skb_datagram_iter(const struct sk_buff *skb, int offset,
> 			struct iov_iter *to, int len,
> 			int (*cb)(void *, int, struct iov_iter *, void *),
> 			void *data)
> {
> 	...
> 		n = cb(skb->data + offset, copy, to, data);
> 	...
> }
> 
> You get the idea.  Then we have one version of all the loops and
> the different (copy, copy+csum, copy+hash) cases all can be
> handled by __skb_datagram_iter() but just with a different 'cb'
> and private 'data'.

I already thought about that, but the fact that we copy both a buffer
and a page to the iter (in the most general case) we'd have to carry
two callbacks for indirection.. That wasn't something I thought as
acceptable...

I guess we could rework skb_copy_datagram_iter to not call
copy_page_to_iter and open-code kmapping so we can get away with a
single code path? Unless I'm missing something?

Also, looking a bit closer there is a slight difference between the copy
vs. the copy_and_csum variants. copy allows for a short_copy if we copy
less than we expect while the csum faults it. I'm thinking that the
copy_and_hash variant should also fault? Although I'm not sure I
understand the fault entirely as csum is supposed to be cumulative, any
insight?
