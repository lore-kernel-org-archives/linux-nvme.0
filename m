From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Tue, 18 Apr 2017 23:27:54 +0800
Subject: NVMe APST on XPS 9550/Precison 5510
In-Reply-To: <8a3fa43e140d445a80f53228b4beee3e@ausx13mpc120.AMER.DELL.COM>
References: <CAAd53p4eGbYSNVgBGCxiL6ev6cVg+kwCZ3Kgt0bMiWt+2EKSjQ@mail.gmail.com>
 <8a3fa43e140d445a80f53228b4beee3e@ausx13mpc120.AMER.DELL.COM>
Message-ID: <CAAd53p4Q2UAE8XjZrOxUQu=R6wkOoFcYOv1LC_JfDWDV=h1YXA@mail.gmail.com>

Mario,

On Tue, Apr 18, 2017@11:19 PM,  <Mario.Limonciello@dell.com> wrote:
> Kai Heng,
>
>>Hi Andy,
>>The new quirk [1] in your nvme/power branch Mario pointd to me disables APST completely, but three different users reported that the NVMe works fine if the deepest state it enters is PS3 (comment #17, #18 and #19).
>>So instead of not enabling APST, can we have a quirk to target specific power state? Users can still get nice powersaving without dead NVMe this way.
>>Also, another user has the same issue on Lenovo ThinkPad X270 (comment #11 and #13), it uses Toshiba NVMe instead of Samsung.
>>
>>[1] https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=nvme/power&id=37294ae0e942e9dc56e869af23cc6face284dec8
>
> Presumably you're referring to this bug? https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184

Thanks, I forgot the most important bug link...

>
> That's some interesting data points that you have found to share with other machines and drive combinations with problems as well
> as limiting the deepest state to enter.
>
> More and more people will be testing this since Ubuntu 17.04 is out with this patch included.
> At least until the problems related to PS4 being entered are properly root caused on the affected combinations, I wonder if it would
> be better to default to the more widely safe PS3 and whitelist combinations that PS4 is safe?

IMO it's a pretty good default for most users. If the NVMe doesn't
lie, PS3 already uses less than 0.1 W.
