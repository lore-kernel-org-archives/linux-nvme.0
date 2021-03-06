Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF1C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:39:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCD764F5F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCD764F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m6ipuy41jFqTpusZTyfWu+w9OwIIaLCQz9hno/r/4I0=; b=dD1w2hV6zyQvQoJxTGKyEGUqPa
	NhiJeKQphJAqtUu6fUgwnE+2nIEyWDerUMbBmqIdEAJ7a0DtAcRym3hB4PW0GGy9GtUZtCDYFJtfE
	1BDGEzNG1EdBk0zrZnpMZH95HK+ClVzVVgz8uoBUtHWc9ptearkSpObWtthR9DLfUgcxYqplEsXH9
	6gC0PE1vDV34O9pBwjjQWOJs1TfGgiTqx6NLs6SGvAjGq/y7M+gcR79DfXSuPKcP8QJcuVmmsZrBU
	rVnI37R5OCGKAlXkCd7HlzBbZcr5Xvvn+BBVFbow12lFjwuL/CtgNdxJnfCXoB7mnCXmLwpMC9TJw
	3XJvs08A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKyw-00HWiQ-5q; Sat, 06 Mar 2021 00:39:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwV-00HVf3-Ks
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uM4uSFPz6K8QS76dUsBTMc+ppk+83Gr1jTXHEXAXWO8=;
 b=mrhi8LldgE6j0TZpxMVjVuwvDUDjMZAfQwB+CvUihdsMjQqKe6Ot8N58DExIZ5EuN7dT8v
 IElGowqvOabhXtiX5BhMZ+iU8JL/+SLGlyzbZLnCxxEPbJISmwuwlWPbCBgJj42Uv758r4
 yYTsCv4VfCeFHM+8yhBtPnOe/vmwh48=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3A6DCAE05;
 Sat,  6 Mar 2021 00:37:15 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 00/16] nvme-cli: add "nvme monitor" subcommand
Date: Sat,  6 Mar 2021 01:36:43 +0100
Message-Id: <20210306003659.21207-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003715_845045_428D32E1 
X-CRM114-Status: GOOD (  34.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

This patch set adds a new subcommand "nvme monitor". In this mode,
nvme-cli runs continuously, monitors various events relevant for discovery,
and autoconnects to newly discovered subsystems.

This series is based on, and requires, my previously submitted patch series
"Some minor fixes/additions for nvme-cli".

The monitor mode is suitable to be run in a systemd service. An appropriate
unit file is provided. As such, "nvme monitor" can be used as an alternative
to the current auto-connection mechanism based on udev rules and systemd
template units.

This method for discovery and autodetection has some advantages over the
current udev-rule based approach:

 * The monitor creates persistent discovery controllers if possible,
   and monitors them for AENs.

 * The monitor tracks "/etc/nvme/discovery.conf" changes using inotify.

 * The monitor keeps record about existing NMVe transport connections and
   associated discovery controllers (if any). Thus it can avoid recreating
   discovery controllers if a persistent discovery controller is already
   present on a given transport address, without having to search sysfs
   for a matching controller.

 * The monitor is aware of ongoing discoveries (as much as it has started
   them itself) and can queue up additional processes without taking the
   risk to miss any events. Missing events is possible with the current
   systemd-based activation of NVMe discovery.

 * I expect slightly less resource usage compared to the current udev-rule
   based discovery, as less fork()/exec() operations are required. The effect
   will probably to be small though, and I have no numbers.

 * The monitor will be able to support network discovery too, and react
   on mDNS records being published in the network. This functionality
   will be implemented using libavahi; Enzo Matsumiya is working on it.
   Once finished, "nvme monitor" will be able to track discovery events
   for every NVMeoF transport.

I've tested `fc_udev_device` handling for NVMeoFC with an Ontap target, and
AEN handling for RDMA using a Linux nvmet target.

# Changes wrt "RFC: add "nvme monitor" subcommand" patch series

A lot.

 * Separated out those changes that are not directly related to the monitor
   into a separate series, as requested by Sagi (see above). The part
   that changes some symbols in fabrics.c from static to global is still
   part of the "monitor" series though, as it doesn't make sense to do
   this without the monitor.

 * Reorganized the patches into less, bigger chunks, as requested by Hannes.

 * Changed the behavior of the monitor:

   - Autoconnect by default, and allow to use "-n/--no-connect" for opt-out.

   - Always create persistent discovery connections (Sagi): it makes no sense
     to use temporary discovery controllers if the monitor is running.

   - Don't try to create discovery controllers on every transport connection
     found. Sagi had pointed out that this behavior in the RFC was wrong.
     Instead, run discoveries from /etc/nvme/discovery.conf on startup.

   - Don't automatically disable 70-nvmf-autoconnect.rules (Hannes).
     I have put this in the systemd service file for now, because I think
     it makes no sense to run the monitor as a systemd service and run the
     discovery via udev rules at the same time. If this is also unwanted,
     I can remove it entirely of course.

 * Moved the event handling into a separate "library". This was motivated
   by the additional events monitored in the v2 series, and by the prospect
   of adding more (and network-related ones, where timeout handling will
   become important) when the mDNS support is merged. I've actually spent
   most work on this part, stabilizing the API, creating tests and fixing
   issues. I have published this separately on https://github.com/mwilck/minivent,
   together with the unit tests that I didn't want to add to the nvme-cli
   patch set at this time.
   
 * Added new features:

   - /etc/nvme/discovery.conf: Parse it on startup, and monitor changes with
     inotify.

   - parent/child messaging: allow children running discovery to communicate
     with the parent monitor process via a Unix socket. Without this, the
     discovery of newly created discovery controllers by the parent is
     fragile, because the monitor has no way to figure out whether a given
     controller was created by its own child or by another process. Also,
     it wasn't possible to pass existing discovery controller devices to
     children running discovery from the conf file, or for referrals. This
     had the effect that children would create a temporary discovery controller
     even though persistent controller for the same connection existed
     already.

 * Use the "udev" udev monitor socket by default rather than "kernel".
   When I made the first submission, I was unaware that filtering on "kernel"
   netlink sockets is much less efficient than on "udev" sockets. Thus
   "kernel" is only used if udevd is not available.

 * Lots of bugs and minor issues fixed.

# Todo

 * Implement support for RDMA and TCP protocols. As noted above, Enzo
   Matsumiya has been working on this, and we are cooperating to merge
   our efforts.

Reviews and comments welcome.
Thanks,

PS: I've pushed both this series and the "minor fixes" series to
    https://github.com/linux-nvme/nvme-cli/pull/877. The CI fails
    because I don't know how to resolve the dependency of libudev
    in the Ubuntu / powerpc cross-compilation environment used there.
    Help would be appreciated.    


Martin Wilck (16):
  fabrics: export symbols required for monitor functionality
  nvme-cli: add code for event and timeout handling
  monitor: add basic "nvme monitor" functionality
  monitor: implement uevent handling
  conn-db: add simple connection registry
  monitor: monitor_discovery(): try to reuse existing controllers
  monitor: kill running discovery tasks on exit
  monitor: add option --cleanup / -C
  monitor: handling of add/remove uevents for nvme controllers
  monitor: discover from conf file on startup
  monitor: watch discovery.conf with inotify
  monitor: add parent/child messaging and "notify" message exchange
  monitor: add "query device" message exchange
  completions: add completions for nvme monitor
  nvmf-autoconnect: add unit file for nvme-monitor.service
  nvme-monitor(1): add man page for nvme-monitor

 .github/workflows/c-cpp.yml                   |    4 +
 Documentation/cmds-main.txt                   |    4 +
 Documentation/nvme-monitor.1                  |  180 +++
 Documentation/nvme-monitor.html               | 1018 ++++++++++++
 Documentation/nvme-monitor.txt                |  144 ++
 Makefile                                      |   21 +-
 common.h                                      |   17 +
 completions/bash-nvme-completion.sh           |    6 +-
 conn-db.c                                     |  425 +++++
 conn-db.h                                     |  171 ++
 event/event.c                                 |  481 ++++++
 event/event.h                                 |  460 ++++++
 event/timeout.c                               |  373 +++++
 event/timeout.h                               |  110 ++
 event/ts-util.c                               |  107 ++
 event/ts-util.h                               |  129 ++
 fabrics.c                                     |  436 +++---
 fabrics.h                                     |   52 +
 list.h                                        |  349 +++++
 monitor.c                                     | 1370 +++++++++++++++++
 monitor.h                                     |   14 +
 nvme-builtin.h                                |    1 +
 nvme.c                                        |   13 +
 nvmf-autoconnect/systemd/nvme-monitor.service |   18 +
 util/cleanup.c                                |    2 +
 util/cleanup.h                                |    1 +
 26 files changed, 5676 insertions(+), 230 deletions(-)
 create mode 100644 Documentation/nvme-monitor.1
 create mode 100644 Documentation/nvme-monitor.html
 create mode 100644 Documentation/nvme-monitor.txt
 create mode 100644 conn-db.c
 create mode 100644 conn-db.h
 create mode 100644 event/event.c
 create mode 100644 event/event.h
 create mode 100644 event/timeout.c
 create mode 100644 event/timeout.h
 create mode 100644 event/ts-util.c
 create mode 100644 event/ts-util.h
 create mode 100644 list.h
 create mode 100644 monitor.c
 create mode 100644 monitor.h
 create mode 100644 nvmf-autoconnect/systemd/nvme-monitor.service

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
