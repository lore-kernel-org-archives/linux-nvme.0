From: olivier.mallinger@ip-maker.com (Olivier Mallinger - IP Maker)
Date: Thu, 05 Mar 2015 15:27:09 +0100
Subject: Testing IO PRP List
Message-ID: <54F867BD.6070806@ip-maker.com>

Hi.

Continuing my investigation to test NVMe feature, I am looking for a way 
to test IO PRP List.

Basically, the driver only creates contiguous queue for both submission 
and completion queues.
To test, I wanted to use nvme-cli to do the following :
   1 - Delete one IO submission queue using "admin-passthru" command
   2 - Delete one IO completion queue using "admin-passthru" command
   3 - Create one IO completion queue using "admin-passthru" command 
with support of PRP List
   4 - Create one IO submission queue using "admin-passthru" command 
with support of PRP List
   5 - Perform many IO read and write to check IO PRP List behavior

I think this sequence will work from a controller point of view, meaning 
that command will be executed and queue deleted and then created.
But from a host point of view, I think (and I need your confirmation 
here) that for step 1 and 2, the "admin-passthru" command will not 
delete the queue definition inside the driver.
"admin-passthru" command used the ioctl NVME_IOCTL_ADMIN_CMD which never 
call the "nvme_create_queue" inside the driver.
Step 3 and 4 will not work for the same reason. Driver will not really 
create a queue from the host point of view.

Can you confirm my analyse is right ?
Do you have any solution to test the IO PRP List ?

Thanks.
Regards.
Olivier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: olivier_mallinger.vcf
Type: text/x-vcard
Size: 316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150305/3838d566/attachment.vcf>
