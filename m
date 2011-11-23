From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Wed, 23 Nov 2011 13:47:20 -0800
Subject: LBA Range handling
In-Reply-To: <20111123213447.GB14291@linux.intel.com>
References: <5AC4D6A45304E048A30F105EB302760902CBB0AF@CORPEXCH1.na.ads.idt.com>
 <20111123213447.GB14291@linux.intel.com>
Message-ID: <5AC4D6A45304E048A30F105EB302760902CBB1D2@CORPEXCH1.na.ads.idt.com>

>> When a SSD is brand new, the LBA range type is going to be "Reserved"

>> as it has never been used.
>
>umm ... it is?  We should probably get the committee to change that
type 0 from Reserved (which means you can't use >it) to 'Unspecified'
>or something ...

I agree.  


>> Do you see any problem with this algorithms ?
>
>Yes.  If the type of the LBA range is 'page cache', for example, then
it needs to be exported to the OS in order for >the OS to use it.  Also,
I think you have the sense of the hidden bit wrong.  The only change I'd
make to my current >algorithm is that we should probably obey the
read-only bit.
>
>Also, I don't know how to handle multiple LBA range types yet ... they
ought to be handled through the Linux partition >mechanism, but it
doesn't have any concept of devices providing their own partitioning
scheme yet.

Actually, I am not sure how do use the LBA range.  Who should set the
LBA Range ? Should it be the driver or the application ?  What should
the driver behave if the type is 'page cache', 'RAID', 'Reserved' or
'FILESYSTEM' ?

How are we supposed to use the LBA range ?

Thanks

-Kwok
