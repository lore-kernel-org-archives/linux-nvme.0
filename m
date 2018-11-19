From: davem@davemloft.net (David Miller)
Date: Mon, 19 Nov 2018 14:53:43 -0800 (PST)
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
References: <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
 <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
Message-ID: <20181119.145343.2254073323355763213.davem@davemloft.net>

From: Sagi Grimberg <sagi@grimberg.me>
Date: Mon, 19 Nov 2018 13:26:12 -0800

> I would love you to look at skb_copy_and_hash_datagram_iter as these
> changes will require an ack from you.

My first impression is that we now have this kind of code pattern
in at least two main places and now this will be a third.

I know that nobody likes callbacks because of spectre, but all of
these cases could be done with something like:

int __skb_datagram_iter(const struct sk_buff *skb, int offset,
			struct iov_iter *to, int len,
			int (*cb)(void *, int, struct iov_iter *, void *),
			void *data)
{
	...
		n = cb(skb->data + offset, copy, to, data);
	...
}

You get the idea.  Then we have one version of all the loops and
the different (copy, copy+csum, copy+hash) cases all can be
handled by __skb_datagram_iter() but just with a different 'cb'
and private 'data'.
