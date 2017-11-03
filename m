From: hare@suse.de (Hannes Reinecke)
Date: Fri,  3 Nov 2017 16:19:28 +0100
Subject: [PATCH 0/1] NVMe-FC autoconnect, second try
Message-ID: <1509722369-95879-1-git-send-email-hare@suse.de>

Hi all,

here's my attempt a NVMe-FC autoconnect.
Primarily it's just a patch adding a 'discovery' sysfs attribute
to /sys/class/fc/nvme_fc_transport.

Writing '1' (or anything) into it will cause nvme-fc to resend uevents
for every known host_traddr:traddr combination.

With that we can then add the simple udev rule:

SUBSYSTEM!="block, GOTO="nvme_autoconnect_end"
ACTION!="add|change", GOTO="nvme_autoconnect_end"
ENV{FC_EVENT}!="nvmediscovery", GOTO="nvme_autoconnect_end"
ENV{NVMEFC_HOST_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
ENV{NVMEFC_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
RUN+="/usr/sbin/nvme connect-all -t fc --host-traddr=$env{NVMEFC_HOST_TRADDR} -a $env{NVMEFC_TRADDR}"
LABEL="nvme_autoconnect_end"

to facilitate autodiscovery.

This does not address the potential stall in nvme connect-all that James
mentioned, but I do think that should be fixed via other means.

Hannes Reinecke (1):
  nvme/fc: add 'discovery' sysfs attribute to fc transport device

 drivers/nvme/host/fc.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 9 deletions(-)

-- 
1.8.5.6
