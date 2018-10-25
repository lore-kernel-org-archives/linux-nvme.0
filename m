From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Oct 2018 09:14:13 -0600
Subject: [PATCH] nvmet: adjust the serial number format function
In-Reply-To: <1540201713-14848-1-git-send-email-lijie34@huawei.com>
References: <1540201713-14848-1-git-send-email-lijie34@huawei.com>
Message-ID: <20181025151413.GC5138@localhost.localdomain>

On Mon, Oct 22, 2018@05:48:33PM +0800, lijie wrote:
> The serial number displayed on the host side using the nvme list command
> is different from the attr_serial at the target side, because the
> nvmet_execute_identify_ctrl function and the
> nvmet_subsys_attr_serial_store function use different types of formatting
> functions.

I think the more fundamental reason for the display difference is one
of these is a u8[] and the other a u64, and it makes more sense to me
if both were u8[].
