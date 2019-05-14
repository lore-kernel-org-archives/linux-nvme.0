From: kbusch@kernel.org (Keith Busch)
Date: Tue, 14 May 2019 11:06:59 -0600
Subject: [PATCH] nvme-cli: align comments for struct telemetry_log_page_hdr
In-Reply-To: <CAC5umyi6GQh38R2q5xpBXisJjFVgkkEcPxnJ-geo1fKHYOLAuw@mail.gmail.com>
References: <1557846878-25595-1-git-send-email-akinobu.mita@gmail.com>
 <70b80155-d4a8-b53e-7022-0f5f704b1338@acm.org>
 <CAC5umyi6GQh38R2q5xpBXisJjFVgkkEcPxnJ-geo1fKHYOLAuw@mail.gmail.com>
Message-ID: <20190514170659.GA19977@localhost.localdomain>

On Wed, May 15, 2019@01:27:36AM +0900, Akinobu Mita wrote:
> 2019?5?15?(?) 0:22 Bart Van Assche <bvanassche at acm.org>:
> >
> > On 5/14/19 5:14 PM, Akinobu Mita wrote:
> > > Align the field member comments for struct telemetry_log_page_hdr.
> > > This also uses tabs instead of spaces to align field members.
> >
> > Hi Akinobu,
> >
> > Have you considered to use the kernel-doc syntax instead of aligning the
> > comments? See also
> > https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt.
> 
> I personally prefer to use the kernel-doc syntax.  So if no one complains,
> I withdraw this patch and will send a patch to convert kernel-doc syntax.

Me too. Kernel style is preferred. We've just been too lenient on
enforcing it, so I would appreciate these style fixes.
