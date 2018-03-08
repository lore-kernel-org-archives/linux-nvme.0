From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Mar 2018 19:14:11 +0200
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <20180307171805.GA810@lst.de>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
 <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>
 <20180307171805.GA810@lst.de>
Message-ID: <92b3a173-7823-d96f-af43-7603ae9894af@grimberg.me>


>> The problem is that it's the first of its kind in regard to virtual
>> slaves/devices and many of the consumers of block device sysfs simply
>> weren't ready for it to appear where it did. Perhaps if it had been a
>> different part of sysfs hierarchy and/or linked up a different way
>> (virtual-slaves/?) it would have been invisible to programs that
>> weren't ready to consume it...
> 
> Yes, I think we should simply creates a paths/ directory.  Not sure
> there is much point in the backlink.

I'm good with this.
