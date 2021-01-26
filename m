Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CAC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1194022A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1194022A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8xKLVsSFcf1jPIPE+Ws4r45fmrEtRNSBrjYXKTw5ORY=; b=aKMeQYQa6SHTPmkgbPVQLSanOv
	pIASagHZ9LLXI+/Suk+9vjJlN9Clrobk8nBQ8lY0U0TgL3U5UbbIXGk35rNapqznNLJ5y4rbx0MVr
	srLgObakV+HJAuTHkpiOwU+scrBFERiMznx45n1wJLboDKzU3E97f+mWwr0qwhsFrtl784aVER32N
	14YOg5CbUG0Pw88s5vNaZW78DlTtNBJF6vXYwxMNizKC178S/pawwtNyMMQk3m7lU+ZdlNTLi9YC6
	s5enw3OxZwX70dyCKAU6I8RI4yZFcnDFJmmEieS9couyzZcc85flmCB4a4021aLj/L2lDok2iFUU8
	BGvgYkHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2M-00015i-Jx; Tue, 26 Jan 2021 20:34:06 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V22-0000tn-EX
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=30//qRtQDGi7CbR5u3n1klMoh7amj5UQCqJ5OQpvQeQ=;
 b=NjPSF8eaFrxYVr5V6hf+Kafhqt4EbonmkSr/8h9ic28u6Ym5ffxNAxYsVKjACo90D/7ZZs
 NGAoHSYRwhbB5s1ktSwXmkEUVbO0LnaBo3jsYVMq1AY24YAV9JDzS59bqGWNbZTcZ9XxZp
 SXpn+GCGpXwHTTJKPdxwGB8uEaSfPFE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A8052AE89;
 Tue, 26 Jan 2021 20:33:42 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 00/35] RFC: add "nvme monitor" subcommand
Date: Tue, 26 Jan 2021 21:32:49 +0100
Message-Id: <20210126203324.23610-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153346_730929_7DED8450 
X-CRM114-Status: GOOD (  26.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

(Cover letter copied from https://github.com/linux-nvme/nvme-cli/pull/877)

This patch set adds a new subcommand **nvme monitor**. In this mode,
**nvme-cli** runs continuously, monitors events (currently, uevents) relevant
for discovery, and optionally autoconnects to newly discovered subsystems.

The monitor mode is suitable to be run in a systemd service. An appropriate
unit file is provided. As such, **nvme monitor** can be used as an alternative
to the current auto-connection mechanism based on udev rules and systemd
template units. If `--autoconnect` is active, **nvme monitor** masks the
respective udev rules in order to prevent simultaneous connection attempts
from udev and itself.

This method for discovery and autodetection has some advantages over the
current udev-rule based approach:

 * By using the `--persistent` option, users can easily control whether
   persistent discovery controllers for discovered transport addresses should
   be created and monitored for AEN events. **nvme monitor** watches known
   transport addresses, creates discovery controllers as required, and re-uses
   existing ones if possible. It keeps track of persistent discovery
   controllers it created, and tears them down on exit. When run in
   `--persistent --autoconnect` mode *in the initial ramfs*, it will keep
   discovery controllers alive, so that a new instance started after switching
   root can simply re-use them.
 * In certain situations, the systemd-based approach may miss events due to
   race conditions. This can happen e.g. if an FC remote port is detected, but
   shortly after it's detection an FC relogin procedure is necessary e.g. due to
   an RSCN. In this case, an `fc_udev_device` uevent will be received on the
   first detection and handled by an `nvme connect-all` command run from
   `nvmf-connect@.service`. The connection attempt to the rport in question will
   fail with "no such device" because of the simultaneous FC
   relogin. `nvmf-connect@.service` may not terminate immediately, because it
   attempts to establish other connections listed in the Discovery Log page it
   retrieved. When the FC relogin eventually finishes, a new uevent will be
   received, and `nvmf-connect@` will be started again, but *this has no effect*
   if the previous `nvmf-connect@` service hasn't finished yet. This is the
   general semantics of systemd services, no easy workaround exists.  **nvme
   monitor** doesn't suffer from this problem. If it sees an uevent for a
   transport address for which a discovery is already running, it will queue the
   handling of this event up and restart the discovery after it's finished.
 * Resource consumption for handling uevents is lower. Instead of running an
   udev worker, executing the rules, executing `systemctl start` from the
   worker, starting a systemd service, and starting a separate **nvme-cli**
   instance, only a single `fork()` operation is necessary. Of course, on the
   back side, the monitor itself consumes resources while it's running and
   waiting for events. On my system with 8 persistent discovery controllers,
   its RSS is ~3MB. CPU consumption is zero as long as no events occur.
 * **nvme monitor** could be easily extended to handle events for non-FC
   transports.

I've tested `fc_udev_device` handling for NVMeoFC with an Ontap target, and
AEN handling for RDMA using a Linux **nvmet** target.

### Implementation notes

I've tried to change the exisiting **nvme-cli** code as little as possible
while reusing the code from `fabrics.c`. The majority of changes in the
existing code exports formerly static functions and variables, so that they
are usable from the monitor code.

The main process just waits for events using `epoll()`. When an event is
received that necessitates a new discovery, a child is forked. This makes it
possible to fill in the configuration parameters for `do_discover()` without
interfering with the main process or other discovery tasks running in
parallel. The program tracks *transport addresses* (called "connections" in
the code) rather than NVMe controllers. In `--persistent` mode, it tries to
maintain exactly one persistent discovery connection per transport address.

Using `epoll()` may look over-engineered at this stage. I hope the better
flexibility over `poll()` (in particular, the ability to add new event sources
while waiting) will simplify future extensions and improvements.

### Todo

 * Referrals are not handled perfectly yet. They will be handled by
   `do_discover()` just as it would when called from **nvme connect-all**, but
   it would be better to pass referrals back to the main process to make it
   aware of the additional discovery controller rather than using
   recursion. The main process would e.g. know if a discovery is already
   running for the transport address in the referrral.
 *  When "add" uevents for nvme controller devices are received, the
    controller is consistently not in `live` state yet, and attempting to read
    the `subsysnqn` sysfs attribute returns `(efault)`. While this should
    arguably be fixed in the kernel, it could be worked around in user space
    by using timers or polling the `state` sysfs attribute for changes.
 * Parse and handle `discovery.conf` on startup.
 * Implement support for RDMA and TCP protocols.


Martin Wilck (35):
  nvme-monitor: add new stub
  monitor: create udev socket
  monitor: initialize signal handling
  monitor: add main loop for uevent monitoring
  monitor: add uevent filters
  monitor: Create a log() macro.
  fabrics: use log() macro
  monitor: add command line options to control logging
  nvme_get_ctrl_attr(): constify "path" argument
  fabrics: export do_discover(), build_options() and config
  monitor: add option -A / --autoconnect
  monitor: add helpers for __attribute__((cleanup))
  monitor: disable nvmf-autoconnect udev rules in autoconnect mode
  monitor: implement handling of fc_udev_device
  monitor: implement handling of nvme AEN events
  monitor: reset children's signal disposition
  monitor: handle SIGCHLD for terminated child processes
  monitor: add "--persistent/-p" flag
  fabrics: use "const char *" in struct config
  fabrics: export arg_str(), parse_conn_arg(), and remove_ctrl()
  nvme-cli: add "list.h"
  conn-db: add simple connection registry
  monitor: handle restart of pending discoveries
  monitor: monitor_discovery(): try to reuse existing controllers
  monitor: read existing connections on startup
  monitor: implement starting discovery controllers on startup
  monitor: implement cleanup of created discovery controllers
  monitor: basic handling of add/remove uevents for nvme controllers
  monitor: kill running discovery tasks on exit
  monitor: add connection property options from connect-all
  completions: add completions for nvme monitor
  nvmf-autoconnect: add unit file for nvme-monitor.service
  nvme-connect-all(1): fix documentation for --quiet/-S
  nvme-monitor(1): add man page for nvme-monitor
  monitor: add option --keep/-K

 Documentation/cmds-main.txt                   |    4 +
 Documentation/nvme-connect-all.1              |    8 +-
 Documentation/nvme-connect-all.html           |   10 +-
 Documentation/nvme-connect-all.txt            |    4 +-
 Documentation/nvme-monitor.1                  |  218 ++++
 Documentation/nvme-monitor.html               | 1067 +++++++++++++++++
 Documentation/nvme-monitor.txt                |  170 +++
 Makefile                                      |   10 +
 common.h                                      |   12 +
 completions/bash-nvme-completion.sh           |    6 +-
 conn-db.c                                     |  341 ++++++
 conn-db.h                                     |  141 +++
 fabrics.c                                     |  145 +--
 fabrics.h                                     |   39 +
 list.h                                        |  365 ++++++
 log.h                                         |   44 +
 monitor.c                                     |  764 ++++++++++++
 monitor.h                                     |    6 +
 nvme-builtin.h                                |    1 +
 nvme-topology.c                               |    2 +-
 nvme.c                                        |   13 +
 nvme.h                                        |    2 +-
 nvmf-autoconnect/systemd/nvme-monitor.service |   17 +
 23 files changed, 3296 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/nvme-monitor.1
 create mode 100644 Documentation/nvme-monitor.html
 create mode 100644 Documentation/nvme-monitor.txt
 create mode 100644 conn-db.c
 create mode 100644 conn-db.h
 create mode 100644 list.h
 create mode 100644 log.h
 create mode 100644 monitor.c
 create mode 100644 monitor.h
 create mode 100644 nvmf-autoconnect/systemd/nvme-monitor.service

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
