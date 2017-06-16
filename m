From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Jun 2017 08:11:03 +0200
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170614150138.GA9428@lst.de>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain> <20170614150138.GA9428@lst.de>
Message-ID: <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>

On 06/14/2017 05:01 PM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017@11:00:25AM -0400, Keith Busch wrote:
>> On Wed, Jun 14, 2017@08:35:35AM +0200, Christoph Hellwig wrote:
>>> TEST UNIT READY wa broken for a year and a half, and FORMAT UNIT and
>>> WRITE BUFFER for two years.  Instead of fixing them up remove them - no
>>> one should be sending SCSI commands to non-scsi devices anyway.
>>
>> This is a step in the right direction, but I don't think it goes far
>> enough. Can we remove the whole thing now?
> 
> I'd love to.  The only real stumbling block was that some version of
> SLES used it for persistent devices names.  So I'd like to sync with
> Hannes and Johannes to make sure they've fixed this up and upstream
> kernels without the scsi translation will work just fine on SLES.
> 
We actually only had an issue with early (ie v1.0 ?) devices, which
wouldn't have any WWID. And we didn't have a 'wwid' sysfs attribute to
boot, making it hard for us to print out any wwid without the SCSI
translation layer.

However, this has been fixed now, so I'm game with dropping it.

Someone should tell HPe, though; apparently they are using it for
firmware download ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
