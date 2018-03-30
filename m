From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 29 Mar 2018 20:23:38 -0400
Subject: [PATCH v3] nvme: expand nvmf_check_if_ready checks
In-Reply-To: <9bba839b-5ddd-5f8b-c8a9-b5ffc10b46b6@gmail.com>
References: <20180328202102.9267-1-jsmart2021@gmail.com>
 <20180329205725.GA7747@redhat.com>
 <9bba839b-5ddd-5f8b-c8a9-b5ffc10b46b6@gmail.com>
Message-ID: <20180330002337.GA8893@redhat.com>

On Thu, Mar 29 2018 at  6:13pm -0400,
James Smart <jsmart2021@gmail.com> wrote:

> Thanks... I'm not sure that this invalidates the patch, as the real
> reason for the patch is to stop the EIO cases without multipath
> where they should have been requeued - the opposite of what you
> want.  I'll take a further look.

I really wasn't making any statement about the patch.  Given you cc'd me
on this patch I thought it was the FAILFAST stuff we talked about last
week.  So I was pointing out I'm not seeing any failfast improvement.
But I'm not confident my mptest test is completely valid... so I was
fishing for your (or others') help.

But looking closer the header does speak to honoring failfast if
present.  dm-multipath does set failfast, so why wouldn't that be
applicable?

Maybe you're saying the patch is more concerned with other details but
did make some attempt to honor failfast..

Mike
