From: james.smart@broadcom.com (James Smart)
Date: Fri, 3 Nov 2017 10:16:07 -0700
Subject: [PATCH 1/1] nvme/fc: add 'discovery' sysfs attribute to fc
 transport device
In-Reply-To: <1509722369-95879-2-git-send-email-hare@suse.de>
References: <1509722369-95879-1-git-send-email-hare@suse.de>
 <1509722369-95879-2-git-send-email-hare@suse.de>
Message-ID: <e0620b86-9ed7-772f-8416-a5033ca6d8d1@broadcom.com>

On 11/3/2017 8:19 AM, Hannes Reinecke wrote:
> The fc transport device should allow for a rediscovery, as userspace
> might have lost the events.
> So add a sysfs entry 'discovery' to trigger the discover uevents.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>
Ok - so I like this as it removes the lpfc-specific script that was 
there to deal with pre-udev-present events that weren't replayed and 
makes it a simple script that access this new attribute. It does not 
change the content or need for the other scripts that service the udev 
event and starts the systemd script to make makes the nvme connect-all call.

Signed-off-by: James Smart <james.smart at broadcom.com>
