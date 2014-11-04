From: keith.busch@intel.com (Keith Busch)
Date: Tue, 4 Nov 2014 14:52:24 +0000 (UTC)
Subject: [PATCH] nvme-user: Minor enhancement and fixes
In-Reply-To: <005601cff83d$63f09b40$2bd1d1c0$@samsung.com>
References: <1414664449-3288-1-git-send-email-s.chawdhary@samsung.com>
 <alpine.LNX.2.00.1410301321520.4225@localhost.lm.intel.com>
 <005601cff83d$63f09b40$2bd1d1c0$@samsung.com>
Message-ID: <alpine.LNX.2.00.1411041448290.4225@localhost.lm.intel.com>

On Tue, 4 Nov 2014, Swati wrote:
>>>  - During Format, if LBA Format Metadata Size(MS) is 0, set Metadata
> Settings to Extended LBA.
>
>> Why? This is what sets identify namespace's FLBAS bit 4. The 1.1b spec
>> clarified this bit is not applicable when metadata size is 0.
>
> As this was not clear before the 1.1b Spec, we have f/w where, if Metadata
> Size is 0 and this bit is not set, the format command fails with error
> status code Ah (enabling metadata to be transferred as part of a separate
> buffer when there is no metadata supported as part of the format selected)
>
> So can we have metadata handling, based on the spec version supported by the
> device?

Instead of assuming all devices prior to 1.1b's clarification have the
same broken behavoir, let's just make this a user settable value.
