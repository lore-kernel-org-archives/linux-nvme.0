From: helen.koike@collabora.co.uk (Helen Koike)
Date: Wed, 11 May 2016 13:50:25 -0300
Subject: [PATCH v2 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <20160421133823.GA13563@infradead.org>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <5718D697.3050800@collabora.co.uk> <20160421133823.GA13563@infradead.org>
Message-ID: <573362D1.3040401@collabora.co.uk>

Hi Christoph

On 21-04-2016 10:38, Christoph Hellwig wrote:
> I've not spent much time at it due to a busy conference week, but there
> are two main comments on why I don't think this is suitable as is
> despite really liking the general idea.
>
>   - I'd really like this to be proposed as an official extension to the
>     NVMe technical workgroup.  I'm also happy to help with making that
>     happen.  I really don't like to merge it until we have some basic
>     agreement on it, although once the basic agreement is there it
>     shouldn't be too hard to also support the older google specific
>     version.  And this is no new feedback, a couple of people including
>     me said that a long time ago, and we've seen zero action on it.


How the process of submitting a proposal to the NVMe technical workgroup 
works? If it is just a matter of sending a document as the entry point 
and as you offered help, I was wondering if you could just forward this 
proposal to them and I can continue the work from that point onwards (as 
we wouldn't like to burden you), would that be possible?

Here is the last draft: 
https://people.collabora.co.uk/~koike/nvme-set-doorbel-mem-v2.odt

Thank you
Helen



>   - the code is a mess in this version.  I really don't see the need for
>     all the ifdefs, but if you really want to keep them they should move
>     out of the main code path and just stub out helpers that would
>     otherwise do work.
>
