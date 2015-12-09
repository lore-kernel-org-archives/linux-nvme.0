From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 9 Dec 2015 00:12:30 -0800
Subject: [PATCH] NVMe: Expose namespace unique identifier to sysfs
In-Reply-To: <20151208191555.GB16241@localhost.localdomain>
References: <1449595605-20735-1-git-send-email-keith.busch@intel.com>
 <20151208185325.GC2457@linux.intel.com>
 <20151208191555.GB16241@localhost.localdomain>
Message-ID: <CAA9_cmfu-ywNO2uCTu8xqDajwXqNtQvPL4gO3UpkMA+AVp5BYQ@mail.gmail.com>

On Tue, Dec 8, 2015@11:15 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, Dec 08, 2015@01:53:25PM -0500, Matthew Wilcox wrote:
>> On Tue, Dec 08, 2015@10:26:45AM -0700, Keith Busch wrote:
>> > This patch determines which the device supports and reports the unique
>> > identifier in new sysfs binary attribute "uuid". The attribute group is
>> > added to the gendisk's kobject directory.
>>
>> I don't understand why we want to produce a binary attribute here instead
>> of a text attribute?  We already have nicely-formatted UUIDs in sysfs
>> (see the %pU specifier to printk)
>
> I don't have a strong opinion here. Just copying scsi vpd83 attribute,
> and thought it's easier for a program to consume as binary, and easy to
> read from the shell with hexdump.

Fwiw, the nvdimm subsystem dumps namespace uuids as text in sysfs, and
libuuid makes it trivial to convert back and forth.
