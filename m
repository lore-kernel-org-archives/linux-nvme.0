From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 May 2016 19:05:37 -0400
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <201605312224.u4VMNvZS024236@mx0a-001b2d01.pphosted.com>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
 <201605312210.u4VM8qNZ046737@mx0a-001b2d01.pphosted.com>
 <20160531222640.GH24107@localhost.localdomain>
 <201605312224.u4VMNvZS024236@mx0a-001b2d01.pphosted.com>
Message-ID: <20160531230537.GI24107@localhost.localdomain>

On Tue, May 31, 2016@07:24:48PM -0300, Guilherme G. Piccoli wrote:
> But imagine a scenario I have multiple nvme devices and want to upgrade the
> firmware for only one. In this case, the procedure is to reset_controller
> only the specific device after the fw activation.
> modprobe the driver in this case it too much.

I agree module reload would be heavy handed in your scenario, but just
trying to establish what conditions you really need the quirk to work.
 
> Now, the quirk needs 2 sec delay, not so big, but not so small value either.
> Would be _desirable_ to have such distinguishing, although we can live
> without it I guess.

The module is typically only loaded once on boot. The driver probes all
controllers in a background task, so it shouldn't be blocking anything
that doesn't need to run IO to the drive. Is the added 2 seconds there
really harming the experience?
 
> But since you just sent the patch unifying the resets, I thought worth
> asking you if it's possible to include some kind of differentiation, or if
> such feature already exists (and I wasn't able to find heheh)

You can know if the controller was initialized once before if it has an
allocated admin tag set.
