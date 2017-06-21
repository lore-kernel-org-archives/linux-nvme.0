From: a.dawn@samsung.com (Arnav Dawn)
Date: Wed, 21 Jun 2017 13:06:31 +0530
Subject: [PATCH V3 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <20170619170551.GK21765@localhost.localdomain>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070845epcas1p361081521580b9ca7bf45605249f992e2@epcas1p3.samsung.com>
 <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
 <20170619170551.GK21765@localhost.localdomain>
Message-ID: <876bfb79-9bf2-1def-2a4e-94d472c08868@samsung.com>

Hi Keith,

Thanks for the review. Please review my comments.


On Monday 19 June 2017 10:35 PM, Keith Busch wrote:
> On Sat, Jun 10, 2017@12:38:42PM +0530, Arnav Dawn wrote:
>
>> +				ctrl->fw_act_timeout = jiffies +
>> +					msecs_to_jiffies(ctrl->mtfa * 100);
> Instead of adding another field to the nvme_ctrl structure, just
> calculate the timeout in your nvme_fw_act_work function.
intention was to  set fw_act_timeout as soon as the AER is received.
Since work could be scheduled after some time, setting timeout in
work function would add that delay to it.
>
>> +			else
>> +				ctrl->fw_act_timeout = jiffies +
>> +					msecs_to_jiffies(admin_timeout * 1000);
>> +
>> +			schedule_delayed_work(&ctrl->fw_act_work, 0);
> If scheduling with 0 delay, why is this delayed work?
I used delayed work so i could use cancel_delayed_work, as cancel_work
was not available.

+    case NVME_AER_ERR_FW_IMG_LOAD:
+        dev_warn(ctrl->device, "FW image load error\n");
+        cancel_delayed_work(&ctrl->fw_act_work);
+        break;
     default:
