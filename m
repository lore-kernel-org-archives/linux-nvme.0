From: jcagle@gmail.com (j cagle)
Date: Tue, 29 Sep 2015 18:10:52 -0500
Subject: Intel P3600 writes after hot add (RHEL7.1)
In-Reply-To: <alpine.LNX.2.00.1509292144070.23840@localhost.lm.intel.com>
References: <CA+At7pUsnjH__0bkcbS7TyaCxdnym0Du6takuuVe9c6jeoK-xQ@mail.gmail.com>
 <alpine.LNX.2.00.1509292129180.23840@localhost.lm.intel.com>
 <alpine.LNX.2.00.1509292144070.23840@localhost.lm.intel.com>
Message-ID: <CA+At7pU3qBAKvQgHT=XJBB5fEWz4_traPjRsuf3v=B3GQjbxpA@mail.gmail.com>

Thanks Keith! That definitely fixed the problem.

John

On Tue, Sep 29, 2015@4:46 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 29 Sep 2015, Keith Busch wrote:
>>
>> The device is hot-added with a mismatched PCI-e Max Payload Size,
>> so data can only go one way: host -> device.
>
>
> Correction, meant device -> host; reads succeed in this scenario, but
> writes will not.
