From: keith.busch@intel.com (Keith Busch)
Date: Thu, 4 Jun 2015 15:26:03 +0000 (UTC)
Subject: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <D195D453.84EA%brandon.schulz@hgst.com>
References: <D195D453.84EA%brandon.schulz@hgst.com>
Message-ID: <alpine.LNX.2.00.1506041518030.15930@localhost.lm.intel.com>

On Thu, 4 Jun 2015, Brandon Schulz wrote:
> Do you plan to merge this into your legacy tree somewhere that we can
> reference in Bugzillas/etc. with the Linux distro vendors?

There is a strong preference with vendors to see fixes upstream prior
to backporting but this is a long-standing percieved weakness in Linux
vs. other operating systems; no one wants to reboot their machine for
a f/w upgrade ... so, okay, I'll apply it to legacy and see if I can
lobby OSVs to take out-of-stream fixes.

> On 6/1/15, 9:13 AM, "Keith Busch" <keith.busch@intel.com> wrote:
>
>> On Sun, 31 May 2015, David Sariel wrote:
>>> Hi Keith, Jens,
>>> Is everything ok with the patch? Do you need anything else from me?
>>> Thanks
>>> D
>>
>> Looks goot to me. This is as far as I can take it though.
