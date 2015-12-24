From: asb@cin.ufpe.br (Angelo Brito)
Date: Wed, 23 Dec 2015 23:49:28 -0300
Subject: NVMe Generic Devices Linux x Windows
In-Reply-To: <1450913181.6363.38.camel@linux.intel.com>
References: <CAMjVwgQ+WicdTLjXb5Xa70XC+BnQdvyob+iGhjBt_t3Z9bw=dA@mail.gmail.com>
 <567666B7.10902@mellanox.com>
 <CAMjVwgTj6FJQD=y-JqDr_CO6OByGe540xxLiATm1oqWhJ5sBkQ@mail.gmail.com>
 <1450913181.6363.38.camel@linux.intel.com>
Message-ID: <CAMjVwgQeF_AuXHYDAA8RRhj0zbPupzYUawppPBwkJzmTerLwDg@mail.gmail.com>

Yeah, I have installed the release 1.4 and it works. The problem is
with the native from Windows.
I have to investigate further why this happens.
But hey, Linux driver works and I am very pleased with it. ;)



Regards,
Angelo Silva Brito.
B.S. in Computer Engineering - UFPE Brazil
http://about.me/angelobrito
_________________________________________________


2015-12-23 20:26 GMT-03:00 J Freyensee <james_p_freyensee at linux.intel.com>:
> On Sun, 2015-12-20@16:02 -0300, Angelo Brito wrote:
>> Thanks Ian.
>> It is really a windows problem. The native driver version is too old.
>
> There is an actively maintained open-source NVMe Windows driver you can
> try and see if that works:
>
> https://www.openfabrics.org/index.php/windows-nvm-express/nvm-express-s
> ubversion-repos.html
>
>>
>>
>> Regards,
>> Angelo Silva Brito.
>> B.S. in Computer Engineering - UFPE Brazil
>> http://about.me/angelobrito
>> _________________________________________________
>>
>>
>> 2015-12-20 5:28 GMT-03:00 Ian Bakshan <ianb at mellanox.com>:
>> > Hello Angelo,
>> >
>> > I recommend to open a support ticket to the Windows driver
>> > provider.
>> > In case this is a Windows built-in driver you need to open the
>> > support
>> > ticket at Microsoft Support Center.
>> >
>> > BR,
>> > Ian
>> >
>> >
>> > On 18/12/2015 21:17, Angelo Brito wrote:
>> > >
>> > > Hello All,
>> > >
>> > > I have a generic NVMe device that works perfectly on Linux but
>> > > does
>> > > not work on Windows. The device is recognized as a Default NVMe
>> > > Controller with Microsoft as vendor but issue an error code 10:
>> > > This
>> > > device cannot start. I am aware that this is a generic error code
>> > > and
>> > > could mean any thing.
>> > >
>> > > I have started to debug from the device perspective and the Host
>> > > CPU
>> > > just writes the MSI configuration registers during startup. I use
>> > > Altera?s PCIe Hard IP to implement the PCIe and my controller is
>> > > hosted on FPGA. The NVMe controller was never started. Is it an
>> > > expected behavior to work on Linux but not on windows?
>> > > Someone can share any more leads to debug? Why windows doesn?t
>> > > start my
>> > > device?
>> > >
>> > >
>> > > Regards,
>> > > Angelo Silva Brito.
>> > > B.S. in Computer Engineering - UFPE Brazil
>> > > http://about.me/angelobrito
>> > > _________________________________________________
>> > >
>> > > _______________________________________________
>> > > Linux-nvme mailing list
>> > > Linux-nvme at lists.infradead.org
>> > > http://lists.infradead.org/mailman/listinfo/linux-nvme
>> >
>> >
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
