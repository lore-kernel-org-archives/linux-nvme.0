From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Wed, 20 Mar 2019 19:33:05 +0200
Subject: your mail
In-Reply-To: <20190320170321.GA27462@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
 <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
 <20190320170321.GA27462@localhost.localdomain>
Message-ID: <80d6ac26870b52d4df95dacb067a9c6f181b1581.camel@redhat.com>

On Wed, 2019-03-20@11:03 -0600, Keith Busch wrote:
> On Wed, Mar 20, 2019@06:30:29PM +0200, Maxim Levitsky wrote:
> > Or instead I can use the block backend, 
> > (but note that currently the block back-end doesn't support polling which is
> > critical for the performance).
> 
> Oh, I think you can do polling through there. For reference, fs/io_uring.c
> has a pretty good implementation that aligns with how you could use it.


That is exactly my thought. The polling recently got lot of improvements in the
block layer, which migh make this feasable.

I will give it a try.

Best regards,
	Maxim Levitsky
