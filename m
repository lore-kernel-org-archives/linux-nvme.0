From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 25 Oct 2018 18:38:19 -0700
Subject: [PATCH] nvmet: adjust the serial number format function
In-Reply-To: <20181025151413.GC5138@localhost.localdomain>
References: <1540201713-14848-1-git-send-email-lijie34@huawei.com>
 <20181025151413.GC5138@localhost.localdomain>
Message-ID: <ad784255-9c36-d590-b06f-f6fbe97f22bb@grimberg.me>


>> The serial number displayed on the host side using the nvme list command
>> is different from the attr_serial at the target side, because the
>> nvmet_execute_identify_ctrl function and the
>> nvmet_subsys_attr_serial_store function use different types of formatting
>> functions.
> 
> I think the more fundamental reason for the display difference is one
> of these is a u8[] and the other a u64, and it makes more sense to me
> if both were u8[].

Agreed, would be better to make subsys serial u8[20] and adjust
show/store configfs routines accordingly
