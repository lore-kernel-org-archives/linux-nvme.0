From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Jun 2014 10:07:24 -0600 (MDT)
Subject: Questions on the correct Asynchronous Event Request Interface
In-Reply-To: <27590910.290271402551648565.JavaMail.weblogic@epml14>
References: <27590910.290271402551648565.JavaMail.weblogic@epml14>
Message-ID: <alpine.LRH.2.03.1406120923340.4699@AMR>

On Wed, 11 Jun 2014, INDRANEEL MUKHERJEE wrote:
> A couple of patches have already been posted on the Asynchronous Event
> Request(AER) admin command.  But there is still no clarity on the what is the
> correct interface to the application.
>
> Here'r some questions to help summarise the requirements & finalise an
> interface so that a patch can follow.  (References to kfifo are based on
> Keith's patch -
> http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html )
>
> 1. Should the Driver return both the Async Event Completion & the
> corresponding GetLogPage together to User Space?
>
> This can help to avoid the Async Event getting masked accidently. It's
> possible that any Application reads the Async Event from kfifo but fails to
> read the corresponding Log Page masking the event indefinitely.

I don't think so. The driver has no gaurantee there is even a user
space app consuming these events. If the driver is unmasking them,
we could continue getting events and overrun older ones.

> 2. How to have provision in driver to set the 'Temperature Threshold' &
> 'Asynchronous Event Configuration' before sending the AER command?
>
> This is needed as Spec says these should be set before the Async Event
> Request command is sent.

Does it? Please point me to the section in the spec, because I'm not
finding it in either 5.2 or 5.12.1.11.

Section 5.12.1.4 for Temperature Threshold feature says:

"The host should configure this feature prior to enabling asynchronous
event notification for the temperature exceeding the threshold".

I take that to mean the host should set the asynchronous event
configuration feature to enable temperature notification after you set
the temperature threshold. All this can be done from user space and async
event requests may be outstanding prior to this without affecting it.

> One way to achieve this is by making these module parameters and doing a
> SetFeature during Probe & Resume operations. If these module parameters are
> provided by user during insmod, driver should ensure that these are set
> before the kthread submits the AER.

What if I have different devices with vastly different temperature
thresholds in my machine?

> 3. Should the contents kfifo be preserved when the system goes into Suspend?

Maybe not. I don't think they would be relevant anymore after a resume.

> 4. Only one application will get any event (kfifo ensures this). Is this
> expected?

That's how it's designed, but I didn't get feedback if that's okay. It's
readable only by root, so the expectation is you know what you're
doing. Any other suggestions are appreciated, though.

> 5. How to have provision in the driver to cancel the current AER cmds and
> send new ones after doing some new Set Feature?

But the controller shouldn't require a new async event request in order
to respond to changed async configuration features.

> This will need the CmdIds for current AREs to be exported to User Space so
> that they can be aborted. Should the Driver support this?
>
> 6. Is the IOCtl interface enough? Or we want to keep the Read/Poll interface?

Is the IOCTL interface enough for what? It's certainly not usable for
async event notification as-is. You want to add a new IOCTL to consume
aysnc events instead of getting them from a read?

> 7. Is there any reference utility that can be looked at to see what such
> monitoring applications expect?

That would be something I'd like to see as well. I've no idea how these
sorts of events are typically consumed so I just made something up.
