From: sitsofe@gmail.com (Sitsofe Wheeler)
Date: Wed, 7 Mar 2018 15:56:36 +0000
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <20180307150344.GE30975@localhost.localdomain>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
Message-ID: <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>

On 7 March 2018@15:03, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Mar 07, 2018@02:40:39PM +0100, Hannes Reinecke wrote:
>> The nice thing about the holders/slave is that one can discover the
>> topology, and potentially figure out any issues (like one path going
>> down etc).
>
> I also thought the sysfs hierarchy was useful, but it sounds like causes
> more problems than it solves. :(

The problem is that it's the first of its kind in regard to virtual
slaves/devices and many of the consumers of block device sysfs simply
weren't ready for it to appear where it did. Perhaps if it had been a
different part of sysfs hierarchy and/or linked up a different way
(virtual-slaves/?) it would have been invisible to programs that
weren't ready to consume it...

-- 
Sitsofe | http://sucs.org/~sits/
