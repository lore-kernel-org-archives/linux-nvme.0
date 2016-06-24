From: kernel@jbeekman.nl (Jethro Beekman)
Date: Fri, 24 Jun 2016 00:45:08 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <20160624073728.GA30277@infradead.org>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160624073728.GA30277@infradead.org>
Message-ID: <576CE504.5020101@jbeekman.nl>

On 24-06-16 00:37, Christoph Hellwig wrote:
> On Sun, Jun 19, 2016@04:06:31PM -0700, Jethro Beekman wrote:
>> Hi all,
>>
>> If an NVMe drive is locked with ATA Security, most commands sent to the drive 
>> will fail. This includes commands sent by the kernel upon discovery to probe 
>> for partitions. The failing happens in such a way that trying to do anything 
>> with the drive (e.g. sending an unlock command; unloading the nvme module) is 
>> basically impossible with the high default command timeout.
> 
> Do you have any spec that defines this ATA security protocol and how
> it applies to NVMe?  The NVMe spec just referes to SPC4 for security
> protocols, and I haven't been able to find a reference to an ATA
> security protocol in it either, but I haven't tried hard yet.

As you found NVMe points to SPC-4. SPC-4 lists protocol 0xEF "ATA Device Server
Password Security" as part of the SECURITY PROTOCOL IN command, pointing to
SAT-2. In one SAT-2 draft I could find there is are these sections

  12 SAT-specific SCSI extensions
  12.5 SAT-specific Security Protocols
  12.5.1 ATA Device Server Password Security Protocol

which provide a pretty straightforward translation of the ATA SECURITY feature
set (except that there is a new command to gather information that would
normally be part of ATA IDENTIFY). I have implemented all this and it seems to
work on my drive.

Jethro
