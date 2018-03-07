From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Mar 2018 18:18:05 +0100
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries
 for hidden controllers"
In-Reply-To: <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
 <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>
Message-ID: <20180307171805.GA810@lst.de>

On Wed, Mar 07, 2018@03:56:36PM +0000, Sitsofe Wheeler wrote:
> The problem is that it's the first of its kind in regard to virtual
> slaves/devices and many of the consumers of block device sysfs simply
> weren't ready for it to appear where it did. Perhaps if it had been a
> different part of sysfs hierarchy and/or linked up a different way
> (virtual-slaves/?) it would have been invisible to programs that
> weren't ready to consume it...

Yes, I think we should simply creates a paths/ directory.  Not sure
there is much point in the backlink.
