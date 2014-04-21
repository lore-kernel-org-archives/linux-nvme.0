From: keith.busch@intel.com (Keith Busch)
Date: Mon, 21 Apr 2014 11:10:34 -0600 (MDT)
Subject: Smart support
In-Reply-To: <1398098919.10783.7.camel@omniknight.lm.intel.com>
References: <1397948471.23478.30.camel@espiritosanto.int.convergent.io>
 <1398098919.10783.7.camel@omniknight.lm.intel.com>
Message-ID: <alpine.LRH.2.03.1404211055140.5490@AMR>

On Mon, 21 Apr 2014, Verma, Vishal L wrote:
>> What's the roadmap for nvme-scsi? Is it going to evolve into a full scsi
>> device translation layer?
>
> I wrote the SCSI emulation layer - and I don't think we currently have
> any plans of extending this further (Matthew, Keith, chime in if I'm
> wrong). Patches are, of course, welcome.

Bug fixes, enhancements and updates as the translation reference changes
would be applied as anyone submits patches, but I don't know of new
features anyone is looking to get out of this layer. I only know of
tools like sg3-utils and other vendor tools being used to exercise the
driver's SCSI path and they seem to work well. Is there something missing?
