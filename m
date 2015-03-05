From: olivier.mallinger@ip-maker.com (Olivier Mallinger - IP Maker)
Date: Thu, 05 Mar 2015 16:24:41 +0100
Subject: Testing IO PRP List
In-Reply-To: <alpine.LNX.2.00.1503051451430.32385@localhost.lm.intel.com>
References: <54F867BD.6070806@ip-maker.com>
 <alpine.LNX.2.00.1503051451430.32385@localhost.lm.intel.com>
Message-ID: <54F87539.2050605@ip-maker.com>

I agree with you concerning the testability of this feature under Linux.
All my investigation lead to the same conclusion.

I will try to test it with an other OS, checking if queue are created 
with PRP List.
The best solution would be a PCIe exerciser but I don't have access to 
such equipment now.

Thanks for your quick answer.
Best regards.
Olivier.

Le 05/03/2015 16:12, Keith Busch a ?crit :
> On Thu, 5 Mar 2015, Olivier Mallinger - IP Maker wrote:
>> Continuing my investigation to test NVMe feature, I am looking for a 
>> way to test IO PRP List.
>>
>> Basically, the driver only creates contiguous queue for both 
>> submission and completion queues.
>> To test, I wanted to use nvme-cli to do the following :
>>  1 - Delete one IO submission queue using "admin-passthru" command
>>  2 - Delete one IO completion queue using "admin-passthru" command
>>  3 - Create one IO completion queue using "admin-passthru" command 
>> with support of PRP List
>>  4 - Create one IO submission queue using "admin-passthru" command 
>> with support of PRP List
>>  5 - Perform many IO read and write to check IO PRP List behavior
>
> I don't think you should delete or create queues from userspace.
> Deleting them out from under the driver is just going to confuse it
> when IO stops working. Creating isn't safe since the user address for
> the queue is pinned in memory only while the passthrough command is in
> flight. Plus the queue memory is freed when the "nvme" program exits
> anyway, but the h/w queue still exists.
>
> The driver does not do any interpretation what-so-ever on passthroughs,
> so while it is possible to send those commands, it's not going to do
> what I think you're looking for.
>
> There's no reason I know of to add support for physically discontiguous
> IO queues in the Linux driver, so I don't think this feature is testable
> in this environment.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: olivier_mallinger.vcf
Type: text/x-vcard
Size: 316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150305/a0e33a9d/attachment.vcf>
