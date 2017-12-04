From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Dec 2017 08:18:19 +0100
Subject: [PATCHv2] nvme/fc: add 'discovery' sysfs attribute to fc
 transport device
In-Reply-To: <aa2b156b-7fa0-dc0d-4885-7ac4b4dd9842@broadcom.com>
References: <1512120436-58685-1-git-send-email-hare@suse.de>
 <aa2b156b-7fa0-dc0d-4885-7ac4b4dd9842@broadcom.com>
Message-ID: <c6214e48-9e26-f2fc-f8f0-9e0b5dac17be@suse.de>

On 12/01/2017 05:21 PM, James Smart wrote:
> On 12/1/2017 1:27 AM, Hannes Reinecke wrote:
>> +??? spin_lock_irqsave(&nvme_fc_lock, flags);
>> +??? list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
>> +??????? list_for_each_entry(rport, &lport->endp_list, endp_list) {
>> +??????????? if (!nvme_fc_lport_get(lport))
>> +??????????????? continue;
>> +??????????? if (!nvme_fc_rport_get(rport))
>> +??????????????? continue;
> 
> ref counting messed up if rport_get fails - need to back out the lport get.
> 
Bah. Correct.

Will be sending a new version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
