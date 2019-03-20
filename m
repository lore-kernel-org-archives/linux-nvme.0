From: kbusch@kernel.org (Keith Busch)
Date: Wed, 20 Mar 2019 11:03:22 -0600
Subject: your mail
In-Reply-To: <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
 <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
Message-ID: <20190320170321.GA27462@localhost.localdomain>

On Wed, Mar 20, 2019@06:30:29PM +0200, Maxim Levitsky wrote:
> Or instead I can use the block backend, 
> (but note that currently the block back-end doesn't support polling which is
> critical for the performance).

Oh, I think you can do polling through there. For reference, fs/io_uring.c
has a pretty good implementation that aligns with how you could use it.
