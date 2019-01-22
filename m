From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 22 Jan 2019 22:04:43 +0100 (CET)
Subject: [PATCH] genirq/affinity: Assign default affinity to pre/post
 vectors
In-Reply-To: <CAAhV-H7=E_uwvGJF5-J7r0LLG4-=MEqOSnyR6ajThp8Qy0UUdg@mail.gmail.com>
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
 <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de>
 <tencent_7CB943266ADCFDB06DDDE6EF@qq.com>
 <alpine.DEB.2.21.1901161016270.1655@nanos.tec.linutronix.de>
 <tencent_0985E6EE28C337614825A2C1@qq.com>
 <CAAhV-H7=E_uwvGJF5-J7r0LLG4-=MEqOSnyR6ajThp8Qy0UUdg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901222150300.1628@nanos.tec.linutronix.de>

Chen,

On Fri, 18 Jan 2019, Huacai Chen wrote:
> > > I did not say that you removed all NULL returns. I said that this function
> > > can return NULL for other reasons and then the same situation will happen.
> > >
> > > If the masks pointer returned is NULL then the calling code or any
> > > subsequent usage needs to handle it properly. Yes, I understand that this
> > > change makes the warning go away for that particular case, but that's not
> > > making it any more correct.
> 
> Hi, Thomas,
> 
> I don't think "nvecs == affd->pre_vectors + affd->post_vectors" is an ERROR,
> so it should be different with "return NULL for other reasons" to the caller. If
> the caller fallback from MSI-X to MSI, it is probably "nvecs=1,pre_vectors=1,
> post_vectors=0". The caller can work perfectly, if pre/post vectors are filled
> with the default affinity.

This is not about 'works'. This is about correctness. So again:

The semantics of that function is, that it returns NULL on error. The
reason for this NULL return is entirely irrelevant for the moment.

  If the calling code or any subsequent code proceeds as if nothing
  happened and later complains about it being NULL, then that logic at the
  calling or subsequent code is broken.

  And just making one particular error case not return NULL does not make
  it less broken because the function still can return NULL. So that
  proposed 'fix' is sunshine programming at best.

Now for the change you are proposing. It's semantically wrong in the face
of multiqueue devices. You are trying to make exactly one particular corner
case "work" by some dubious definition of work:

     nvecs=1,pre_vectors=1,post_vectors=0

If pre + post != 1 then this still returns NULL and the same wreckage
happens again.

The point is that if there are not enough vectors to have at least one
queue vector aside of pre and post then the whole queue management logic
does not make any sense. This needs to be fixed elsewhere and not duct tape
in the core logic with the argument 'works for me'.

Thanks,

	tglx
