Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A4C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:45:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F8C65077
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F8C65077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pMqEmR7XsRMFZ/556xgB41bdWSkydbO6Y8jo0gZqrW4=; b=ZrDtiZ9Kvhpmc193sgVHG3e/y
	muZ1kd8eWyQw5/iu0Aj/SvwVPlNgZh4VfE4+1inPwlBrBI66NTD43cf/+RZ9ybh/R23UtJT2JS4/1
	1zQIo/+B00f6rfOZaYILenl4XU1wdCgfuyxHTdKagCkqfN03o4SxTfD4xbvzwZ4PihZeEHOf6pBaR
	7qQQqOm6lWEkYCWAZMocCv4y8HnfBmkiGevmKFf+ahT+S5a83REtpV9UdWfL75fGBlS4fbAngqxDW
	i8KoxGgQGiA8yxAmt+vBTLc/6I4gK5ybQszlq5885q7v8wjJg2NqWgW3YSBk9ku+qWhElRqd97QKj
	uMmjAsIVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL4H-00HYJN-Ho; Sat, 06 Mar 2021 00:45:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwW-00HVfT-DK
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWFbrBPWHAtf6LOk1xVUkqlNfj3jbGX0Fa5PGe1AQPg=;
 b=KoIpC9FskxwprGxHwEuHZ/xpNP3yRod+8k/FDxzP1FveGnrGebDLAYgMYT616llE/M379m
 Pbt/OvEGL/M20EVVpHdFNl3gMEj4IRhh5ulWhfN+2B3L+UkkU5hcHmdHhVtd8e8FVXiAnR
 Q0AWD05CV5fSYZAHLUbR/0ICpLPPYXc=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0591FAE89;
 Sat,  6 Mar 2021 00:37:16 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 02/16] nvme-cli: add code for event and timeout handling
Date: Sat,  6 Mar 2021 01:36:45 +0100
Message-Id: <20210306003659.21207-3-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003719_179945_8089DBF7 
X-CRM114-Status: GOOD (  31.64  )
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

For the nvme monitor functionality, an event handling mechanism
will be necessary which deals with event timeouts. While there are standard
solutions for this (e.g. libevent), these add unnecessary complexity
and dependencies to nvme-cli.

Add a small, straighforward event and timeout handling code based
on epoll and timerfd.

This code is identical to what I've pushed recently to
https://github.com/mwilck/minivent, where I added a couple of unit
tests to make sure the code is as robust as it needs to be.
---
 Makefile        |  11 +-
 common.h        |  17 ++
 event/event.c   | 481 ++++++++++++++++++++++++++++++++++++++++++++++++
 event/event.h   | 460 +++++++++++++++++++++++++++++++++++++++++++++
 event/timeout.c | 373 +++++++++++++++++++++++++++++++++++++
 event/timeout.h | 110 +++++++++++
 event/ts-util.c | 107 +++++++++++
 event/ts-util.h | 129 +++++++++++++
 8 files changed, 1683 insertions(+), 5 deletions(-)
 create mode 100644 event/event.c
 create mode 100644 event/event.h
 create mode 100644 event/timeout.c
 create mode 100644 event/timeout.h
 create mode 100644 event/ts-util.c
 create mode 100644 event/ts-util.h

diff --git a/Makefile b/Makefile
index 1fe693c..ad18d47 100644
--- a/Makefile
+++ b/Makefile
@@ -63,6 +63,7 @@ OBJS := nvme-print.o nvme-ioctl.o nvme-rpmb.o \
 	nvme-status.o nvme-filters.o nvme-topology.o
 
 UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o util/log.o
+EVENT_OBJS := event/event.o event/timeout.o event/ts-util.o
 
 PLUGIN_OBJS :=					\
 	plugins/intel/intel-nvme.o		\
@@ -83,11 +84,11 @@ PLUGIN_OBJS :=					\
 	plugins/transcend/transcend-nvme.o	\
 	plugins/zns/zns.o
 
-nvme: nvme.c nvme.h $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) NVME-VERSION-FILE
-	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) $< -o $(NVME) $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) $(LDFLAGS)
+nvme: nvme.c nvme.h $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) $(EVENT_OBJS) NVME-VERSION-FILE
+	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) $< -o $(NVME) $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) $(EVENT_OBJS) $(LDFLAGS)
 
-verify-no-dep: nvme.c nvme.h $(OBJS) $(UTIL_OBJS) NVME-VERSION-FILE
-	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) $< -o $@ $(OBJS) $(UTIL_OBJS) $(LDFLAGS)
+verify-no-dep: nvme.c nvme.h $(OBJS) $(UTIL_OBJS)$(EVENT_OBJS)  NVME-VERSION-FILE
+	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) $< -o $@ $(OBJS) $(UTIL_OBJS) $(EVENT_OBJS) $(LDFLAGS)
 
 nvme.o: nvme.c nvme.h nvme-print.h nvme-ioctl.h util/argconfig.h util/suffix.h nvme-lightnvm.h fabrics.h
 	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c $<
@@ -107,7 +108,7 @@ test:
 all: doc
 
 clean:
-	$(RM) $(NVME) $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) *~ a.out NVME-VERSION-FILE *.tar* nvme.spec version control nvme-*.deb 70-nvmf-autoconnect.conf
+	$(RM) $(NVME) $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) $(EVENT_OBJS) *~ a.out NVME-VERSION-FILE *.tar* nvme.spec version control nvme-*.deb 70-nvmf-autoconnect.conf
 	$(MAKE) -C Documentation clean
 	$(RM) tests/*.pyc
 	$(RM) verify-no-dep
diff --git a/common.h b/common.h
index 1c214a4..4a5a8da 100644
--- a/common.h
+++ b/common.h
@@ -12,4 +12,21 @@
 #define __stringify_1(x...) #x
 #define __stringify(x...)  __stringify_1(x)
 
+/**
+ * container_of - cast a member of a structure out to the containing structure
+ *
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ */
+#define container_of_const(ptr, type, member) ({	\
+	typeof( ((const type *)0)->member ) *__mptr = (ptr);	\
+	(const type *)( (const char *)__mptr - offsetof(type,member) );})
+#define container_of(ptr, type, member) ({		\
+	typeof( ((type *)0)->member ) *__mptr = (ptr);	\
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
+#define STEAL_PTR(p) ({ typeof(p) __tmp = (p); (p) = NULL; __tmp; })
+
 #endif
diff --git a/event/event.c b/event/event.c
new file mode 100644
index 0000000..b4a4101
--- /dev/null
+++ b/event/event.c
@@ -0,0 +1,481 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/epoll.h>
+#include <stdbool.h>
+#include <syslog.h>
+#include <string.h>
+#include <limits.h>
+#define LOG_FUNCNAME 1
+#include "log.h"
+#include "common.h"
+#include "cleanup.h"
+#include "event.h"
+#include "timeout.h"
+
+/* size of events array in call to epoll_pwait() */
+#define MAX_EVENTS 8
+#define LEN_CHUNK 8
+
+struct dispatcher {
+	int epoll_fd;
+	bool exiting;
+	struct event *timeout_event;
+	unsigned int len, n, free;
+	struct event **events;
+};
+
+const char * const reason_str[__MAX_CALLBACK_REASON] = {
+	[REASON_EVENT_OCCURED] = "event occured",
+	[REASON_TIMEOUT] = "timeout",
+};
+
+static int _dispatcher_increase(struct dispatcher *dsp)
+{
+	struct event **new;
+
+	if (dsp->len >= UINT_MAX - LEN_CHUNK)
+		return -EOVERFLOW;
+	new = realloc(dsp->events, (dsp->len + LEN_CHUNK) * sizeof(*new));
+	if (!new)
+		return -ENOMEM;
+	dsp->len += LEN_CHUNK;
+	dsp->events = new;
+	msg(LOG_DEBUG, "new size: %u\n", dsp->len);
+	return 0;
+}
+
+static unsigned int _dispatcher_find(const struct dispatcher *dsp,
+				     const struct event *evt)
+{
+	unsigned int i;
+
+	for (i = 0; i < dsp->n; i++)
+		if (dsp->events[i] == evt)
+			return i;
+	return UINT_MAX;
+}
+
+static int _dispatcher_add(struct dispatcher *dsp, struct event *evt)
+{
+	unsigned int i;
+	int rc;
+
+	if (_dispatcher_find(dsp, evt) != UINT_MAX)
+		return -EEXIST;
+
+	if (dsp->free > 0) {
+		for (i = 0; i < dsp->n; i++) {
+			if (dsp->events[i] == NULL)
+				break;
+		}
+		if (i == dsp->n) {
+			msg(LOG_WARNING, "free=%u, but no empty slot found\n",
+			    dsp->free);
+			dsp->free = 0;
+		} else {
+			dsp->events[i] = evt;
+			dsp->free--;
+			msg(LOG_DEBUG, "new event @%u, %u/%u/%u free\n",
+			    i, dsp->free, dsp->n, dsp->len);
+			return 0;
+		}
+	}
+
+	if (dsp->len == dsp->n)
+		if ((rc = _dispatcher_increase(dsp)) < 0)
+			return rc;
+
+	dsp->events[dsp->n] = evt;
+	dsp->n++;
+	msg(LOG_DEBUG, "new event @%u, %u/%u/%u free\n",
+	    dsp->n, dsp->free, dsp->n, dsp->len);
+	return 0;
+}
+
+static int _dispatcher_gc(struct dispatcher *dsp) {
+	unsigned int i, n;
+        struct event **new;
+
+	if (dsp->free <= dsp->len / 4)
+		return 0;
+
+	n = dsp->n;
+	for (i = n; i > 0; i--) {
+		unsigned int j;
+
+		if (dsp->events[i - 1] != NULL)
+			continue;
+
+		for (j = i - 1; j > 0; j--)
+			if (dsp->events[j - 1] != NULL)
+				break;
+
+		memmove(&dsp->events[j], &dsp->events[i],
+			(dsp->n - i) * sizeof(*dsp->events));
+
+		n -= (i - j);
+		if (j == 0)
+			break;
+		else
+			i = j;
+	}
+
+	if (dsp->n - n  != dsp->free)
+		msg(LOG_ERR, "error: %u != %u\n", dsp->free, dsp->n - n);
+	else {
+		msg(LOG_DEBUG, "collected %u slots\n", dsp->free);
+		dsp->n = n;
+		dsp->free = 0;
+	}
+
+	for (i = 0; i < dsp->n; i++) {
+		if (dsp->events[i] == NULL)
+			msg(LOG_ERR, "error at %u\n", i);
+	}
+
+	if (dsp->len <= 2 * LEN_CHUNK || dsp->n >= dsp->len / 2)
+		return 0;
+
+	new = realloc(dsp->events, (dsp->len / 2) * sizeof(*new));
+	if (!new)
+		return -ENOMEM;
+	dsp->events = new;
+	dsp->len = dsp->len / 2;
+
+	msg(LOG_NOTICE, "new size: %u/%u\n", dsp->n, dsp->len);
+	return 0;
+}
+
+static int _dispatcher_remove(struct dispatcher *dsp, struct event *ev)
+{
+	unsigned int i;
+
+	if ((i = _dispatcher_find(dsp, ev)) == UINT_MAX) {
+		msg(LOG_NOTICE, "event not found\n");
+		return -ENOENT;
+	}
+
+	dsp->events[i] = NULL;
+	if (i == dsp->n - 1)
+		dsp->n--;
+	else
+		dsp->free++;
+
+	msg(LOG_DEBUG, "removed event @%u, %u/%u/%u free\n",
+	    i, dsp->free, dsp->n, dsp->len);
+
+	return _dispatcher_gc(dsp);
+}
+
+int _event_remove(struct event *evt)
+{
+	if (evt->fd != -1) {
+		int rc = epoll_ctl(evt->dsp->epoll_fd, EPOLL_CTL_DEL, evt->fd, NULL);
+
+		if (rc == -1)
+			msg(LOG_ERR, "EPOLL_CTL_DEL: %m");
+		return rc;
+	} else
+		return 0;
+}
+
+static void _run_cleanup_handlers(struct dispatcher *dsp, bool do_epoll)
+{
+	unsigned int i;
+
+	for (i = 0; i < dsp->n; i++) {
+		struct event *evt = dsp->events[i];
+
+		if (!evt)
+			continue;
+
+		if (do_epoll)
+			_event_remove(evt);
+		if (evt->cleanup)
+			evt->cleanup(evt);
+	}
+}
+
+int cleanup_dispatcher(struct dispatcher *dsp)
+{
+
+	if (!dsp)
+		return -EINVAL;
+	if (dsp->exiting)
+		return 0;
+
+	dsp->exiting = true;
+
+	_run_cleanup_handlers(dsp, true);
+	timeout_reset(dsp->timeout_event);
+
+	dsp->len = dsp->n = dsp->free = 0;
+	free(dsp->events);
+	dsp->events = NULL;
+	dsp->exiting = false;
+	return 0;
+}
+
+void free_dispatcher(struct dispatcher *dsp)
+{
+	if (!dsp)
+		return;
+
+	/*
+	 * If this function is called e.g. after fork(), we must not
+	 * call epoll_ctl() or reset the timerfd (thus not call timeout_reset()).
+	 * Just close the dup'd timerfd and epoll_fd, and free memory.
+	 */
+	_run_cleanup_handlers(dsp, false);
+	if (dsp->timeout_event)
+		free_timeout_event(dsp->timeout_event);
+	if (dsp->epoll_fd != -1)
+		close(dsp->epoll_fd);
+	free(dsp->events);
+	free(dsp);
+}
+
+static DEFINE_CLEANUP_FUNC(free_dsp_p, struct dispatcher *, free_dispatcher);
+static int _event_add(struct dispatcher *dsp, struct event *evt);
+
+struct dispatcher *new_dispatcher(int clocksrc)
+{
+	struct dispatcher *dsp __cleanup__(free_dsp_p) = NULL;
+
+	dsp = calloc(1, sizeof(*dsp));
+	if (!dsp)
+		return NULL;
+
+	if ((dsp->epoll_fd = epoll_create1(EPOLL_CLOEXEC)) == -1) {
+		msg(LOG_ERR, "epoll_create1: %m\n");
+		return NULL;
+	}
+
+	if (!(dsp->timeout_event = new_timeout_event(clocksrc))) {
+		msg(LOG_ERR, "failed to create timeout event: %m\n");
+		return NULL;
+	}
+
+	/* Don't use event_add() here, timeout is tracked separately */
+	if (_event_add(dsp, dsp->timeout_event) != 0) {
+		msg(LOG_ERR, "failed to dispatch timeout event: %m\n");
+		return NULL;
+	} else
+		return STEAL_PTR(dsp);
+}
+
+int dispatcher_get_efd(const struct dispatcher *dsp)
+{
+	if (!dsp)
+		return -EINVAL;
+	return dsp->epoll_fd;
+}
+
+static int _event_add(struct dispatcher *dsp, struct event *evt)
+{
+	evt->ep.data.ptr = evt;
+	if (evt->fd != -1 &&
+	    epoll_ctl(dsp->epoll_fd, EPOLL_CTL_ADD, evt->fd, &evt->ep) == -1) {
+		msg(LOG_ERR, "failed to add event: %m\n");
+		_dispatcher_remove(evt->dsp, evt);
+		return -errno;
+	}
+	evt->dsp = dsp;
+	evt->reason = 0;
+	return timeout_add(dsp->timeout_event, evt);
+}
+
+int event_add(struct dispatcher *dsp, struct event *evt)
+{
+	int rc;
+
+	if (!dsp || !evt || !evt->callback)
+		return -EINVAL;
+	if (dsp->exiting)
+		return -EBUSY;
+	if ((rc = _dispatcher_add(dsp, evt)) < 0)
+		return rc;
+	return _event_add(dsp, evt);
+}
+
+int event_remove(struct event *evt)
+{
+	int rc;
+
+	if (!evt || !evt->dsp)
+		return -EINVAL;
+
+	rc = _event_remove(evt);
+	if (rc == -1)
+		rc = -errno;
+
+	_dispatcher_remove(evt->dsp, evt);
+	timeout_cancel(evt->dsp->timeout_event, evt);
+	evt->dsp = NULL;
+
+	return rc;
+}
+
+int event_mod_timeout(struct event *evt, const struct timespec *tmo)
+{
+	unsigned int i;
+	struct timespec ts;
+
+	if (!evt || !evt->dsp || !tmo)
+		return -EINVAL;
+	if (evt->dsp->exiting)
+		return -EBUSY;
+	if ((i = _dispatcher_find(evt->dsp, evt)) == UINT_MAX) {
+		msg(LOG_WARNING, "attempt to modify non-existing event\n");
+		return -EEXIST;
+	}
+
+	ts = *tmo;
+	return timeout_modify(evt->dsp->timeout_event, evt, &ts);
+}
+
+int event_modify(struct event *evt)
+{
+	int rc;
+	unsigned int i;
+
+	if (!evt || !evt->dsp)
+		return -EINVAL;
+	if (evt->dsp->exiting)
+		return -EBUSY;
+	if ((i = _dispatcher_find(evt->dsp, evt)) == UINT_MAX) {
+		msg(LOG_WARNING, "attempt to modify non-existing event\n");
+		return -EEXIST;
+	}
+	rc= epoll_ctl(evt->dsp->epoll_fd, EPOLL_CTL_MOD,
+			   evt->fd, &evt->ep);
+	return rc == -1 ? -errno : 0;
+}
+
+void _event_invoke_callback(struct event *ev, unsigned short reason,
+			   unsigned int events, bool reset_reason)
+{
+	int rc;
+
+	if (ev->reason) {
+		msg(LOG_INFO, "skipping callback for %s because of %s\n",
+		    reason_str[reason], reason_str[ev->reason]);
+		return;
+	}
+
+	ev->reason = reason;
+	rc = ev->callback(ev, events);
+
+	if (rc == EVENTCB_CLEANUP) {
+		msg(LOG_DEBUG, "cleaning out event\n");
+		event_remove(ev);
+		if (ev->cleanup)
+			ev->cleanup(ev);
+	} else if (rc == EVENTCB_REMOVE) {
+		msg(LOG_DEBUG, "removing event\n");
+		event_remove(ev);
+		ev->reason = 0;
+	} else if (reset_reason)
+		ev->reason = 0;
+}
+
+
+int event_wait(const struct dispatcher *dsp, const sigset_t *sigmask)
+{
+	int ep_fd = dispatcher_get_efd(dsp);
+	int rc, i;
+	struct epoll_event events[MAX_EVENTS];
+	struct epoll_event *tmo_event = NULL;
+
+	if (!dsp)
+		return -EINVAL;
+	if (dsp->exiting)
+		return -EBUSY;
+	if (ep_fd < 0)
+		return -EINVAL;
+
+	rc = epoll_pwait(ep_fd, events, MAX_EVENTS, -1, sigmask);
+	if (rc == -1) {
+		msg(errno == EINTR ? LOG_DEBUG : LOG_WARNING,
+		    "epoll_pwait: %m\n");
+		return -errno;
+	}
+
+	msg(LOG_DEBUG, "received %d events\n", rc);
+	for (i = 0; i < rc; i++) {
+		struct event *ev = events[i].data.ptr;
+
+		if (ev == dsp->timeout_event)
+			tmo_event = &events[i];
+		else
+			_event_invoke_callback(ev, REASON_EVENT_OCCURED,
+					       events[i].events, false);
+	}
+
+	if (tmo_event) {
+		struct event *ev = tmo_event->data.ptr;
+
+		_event_invoke_callback(ev, REASON_EVENT_OCCURED,
+					    tmo_event->events, false);
+	}
+
+	for (i = 0; i < rc; i++) {
+		struct event *ev = events[i].data.ptr;
+		ev->reason = 0;
+	}
+
+	return ELOOP_CONTINUE;
+}
+
+int event_loop(const struct dispatcher *dsp, const sigset_t *sigmask,
+	       int (*err_handler)(int err))
+{
+	int rc;
+
+	do {
+		rc = event_wait(dsp, sigmask);
+		if (rc < 0 && err_handler)
+			rc = err_handler(-errno);
+	} while (rc == ELOOP_CONTINUE);
+
+	return rc;
+}
+
+void cleanup_event_on_stack(struct event *evt)
+{
+	if (!evt)
+		return;
+	if (evt->fd != -1)
+		close(evt->fd);
+}
+
+void cleanup_event_on_heap(struct event *evt)
+{
+	if (!evt)
+		return;
+	cleanup_event_on_stack(evt);
+	free(evt);
+}
+
+int _call_timer_cb(struct event *evt, uint32_t events __attribute__((unused)))
+{
+	struct timer_event *tim = container_of(evt, struct timer_event, e);
+
+	if (!evt)
+		return -EINVAL;
+
+	tim->timer_fn(tim->timer_arg);
+	return EVENTCB_CLEANUP;
+}
+
+int dispatcher_get_clocksource(const struct dispatcher *dsp)
+{
+	if (!dsp)
+		return -EINVAL;
+	return timeout_get_clocksource(dsp->timeout_event);
+}
diff --git a/event/event.h b/event/event.h
new file mode 100644
index 0000000..ff892f1
--- /dev/null
+++ b/event/event.h
@@ -0,0 +1,460 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#ifndef _EVENT_H
+#define _EVENT_H
+#include <stddef.h>
+#include <sys/epoll.h>
+
+struct event;
+struct dispatcher;
+
+/**
+ * reason codes for event callback function
+ * @REASON_EVENT_OCCURED: the event has occured
+ * @REASON_TIMEOUT: the timeout has expired
+ * @REASON_CLEANUP: dispatcher is about to exit
+ */
+enum {
+	REASON_EVENT_OCCURED,
+	REASON_TIMEOUT,
+	__MAX_CALLBACK_REASON,
+};
+
+/*
+ * reason_str: string representation for the reason a callback is called.
+ */
+extern const char * const reason_str[__MAX_CALLBACK_REASON];
+
+/**
+ * Return codes for callback function
+ * @EVENTCB_CONTINUE:  continue processing
+ * @EVENTCB_REMOVE:    remove this event
+ * @EVENTCB_CLEANUP:   call the cleanup callback (implies EVENTCB_REMOVE)
+ */
+enum {
+	EVENTCB_CONTINUE = 0,
+	EVENTCB_REMOVE =   1,
+	EVENTCB_CLEANUP =  2,
+};
+
+/*
+ * Flags for struct event
+ */
+enum {
+	/*
+	 * timeout is absolute time, not relative.
+	 * Used in event_add() and event_modify_timeout()
+	 */
+	TMO_ABS = 1,
+};
+
+/**
+ * Prototype for event callback.
+ *
+ * @evt: the event object which registered the callback
+ * @events: bit mask of epoll events (see epoll_ctl(2))
+ *
+ * In the callback, check event->reason to obtain the reason the
+ * callback was called for.
+ *
+ * NOTE: race conditions between timeout and event completion can't
+ * be fully avoided. Even if called with @REASON_TIMEOUT, the callback
+ * should check whether an event might have arrived in the meantime,
+ * and in this case, handle the event as if it had arrived before
+ * the timeout.
+ *
+ * CAUTION: don not free() @evt in this callback.
+ *
+ * Return: an EVENTCB_xxx value (see above).
+ */
+typedef int (*cb_fn)(struct event *evt, uint32_t events);
+
+/**
+ * Prototype for cleanup callback.
+ * @evt: the event object which registered the callback
+ *
+ * Called for this event if the event callback returned EVENTCB_CLEANUP, and
+ * from cleanup_dispatcher() / free_dispatcher(), for all registered events.
+ *
+ * If this callback is called, the event has already been
+ * removed from the dispatcher's internal lists. Use this callback
+ * to free the event (if necessary), close file descriptors, and
+ * release other resources as appropriate.
+ *
+ * @evt: the event object which registered the callback
+ */
+typedef void (*cleanup_fn)(struct event *evt);
+
+
+/**
+ * cleanup_event_on_stack() - convenience cleanup callback
+ * @evt: the event object which registered the callback
+ *
+ * This cleanup function simply closes @evt->fd.
+ */
+void cleanup_event_on_stack(struct event *evt);
+
+/**
+ * cleanup_event_on_heap() - convenience cleanup callback
+ * @evt: the event object which registered the callback
+ *
+ * This cleanup function closes @evt->fd and frees @eft.
+ */
+void cleanup_event_on_heap(struct event *evt);
+
+/**
+ * struct event - data structure for a generic event with timeout
+ *
+ * For best results, embed this data structure in the data you need.
+ *
+ * @ep: struct epoll_event. Fill in the @ep.events field with the epoll event
+ *      types you're interested in (see epoll_ctl(2)). If @ep.events is
+ *      0, the event is "disabled"; the timeout will still be active if set.
+ *      CAUTION: don't touch ep.data, it's used by the dispatcher internally.
+ * @fd: the file desciptor to monitor. Use -1 (and fill in the tmo field)
+ *      to create a timer.
+ *      Note: don't change the fd field after creating the event. In particular,
+ *      setting a positve fd after calling event_add with fd == -1 is not allowed.
+ * @callback: the callback function to be called if the event occurs or
+ *      times out. This field *must* be set.
+ * @dispatcher: the dispatcher object to which this event belongs
+ * @tmo: The timeout for the event.
+ *      Setting @tmo.tv_sec = @tmo.tv_nsec = 0 on calls to event_add()
+ *      creates an event with no (=infinite) timeout.
+ *      CAUTION: USED INTERNALLY. Do not change this any more after calling
+ *      event_add(), after event_finish(), it may be set again. The field
+ *      may be modified by the dispatcher code. To change the timeout,
+ *      call event_mod_timeout().
+ * @flags: See above. Currently only @TMO_ABS is supported. This field may
+ *      be used internally by the dispatcher, be sure to set or clear only
+ *      public bits.
+ */
+
+struct event {
+	struct epoll_event ep;
+	int fd;
+	unsigned short reason;
+	unsigned short flags;
+	struct dispatcher *dsp;
+	struct timespec tmo;
+	cb_fn callback;
+	cleanup_fn cleanup;
+};
+
+/**
+ * event_add() - add an event to be monitored.
+ *
+ * @dispatcher: a dispatcher object
+ * @event: an event structure. See the description above for the
+ *
+ * Return: 0 on success, negative error code (-errno) on failure.
+ */
+int event_add(struct dispatcher *dsp, struct event *event);
+
+/**
+ * event_remove() - remove the event from epoll.
+ *
+ * @event: a previously added event structure
+ *
+ * Removes the event from the dispatcher, and cancels the associated
+ * timeout (if any).
+ *
+ * CAUTION: don't call this from callbacks. Use EVENTCB_xxx return codes
+ * instead.
+ *
+ * Return: 0 on success, negative error code (-errno) on failure.
+ */
+int event_remove(struct event *event);
+
+/**
+ * event_modify() - modify epoll events to wait for
+ *
+ * @event: a previously added event structure
+ *
+ * Call this function to change the epoll events (event->ep.events).
+ * By setting @ep.events = 0, the event is temporarily disabled and
+ * can be re-enabled later. NOTE: this function doesn't disable an
+ * active timeout; use event_mod_timeout() for that.
+ *
+ * Return: 0 on success, negative error code (-errno) on failure.
+ */
+int event_modify(struct event *event);
+
+/**
+ * event_mod_timeout() - modify or re-arm timeout for an event
+ *
+ * @event: a previously added event structure
+ * @tmo: the new timeout value
+ *
+ * Call this function to modify or re-enable a timeout for an event.
+ * It can (and must!) be used from the callback to change the timeout
+ * if the event occured, to wait longer if it has timed out. 
+ * If @tmo->tv_sec and @tmo->tv_nsec are both 0, an existing timeout is
+ * cleared (an inifinite timeout is used for this event), as if the tmo field
+ * had been set to { 0, 0 } in the call to event_add().  Set or clear
+ * @event->flags to indicate whether @tmo is an absolute or relative
+ * timeout. Note that the flags fields is "remembered", so if you want to use
+ * a relative timeout after having used an absolute timeout before, you must
+ * clear the @TMO_ABS field in event->flags before calling this function.
+ *
+ * NOTE: if the callback is called with reason REASON_TIMEOUT, the timeout
+ * has expired and *must* be rearmed if the event is monitored further.
+ * Otherwise, the timeout will implicitly be changed to "infinite", because
+ * there is no timeout for this event any more.
+ *
+ * Return: 0 on success, negative error code (-errno) on failure.
+ */
+int event_mod_timeout(struct event *event, const struct timespec *tmo);
+
+/**
+ * int _event_invoke_callback - handle callback invocation
+ * @reason: one of the reason codes above
+ *
+ * Internal use only.
+ */
+void _event_invoke_callback(struct event *, unsigned short, unsigned int, bool);
+
+/**
+ * event_wait(): wait for events or timeouts, once
+ *
+ * @dispatcher: a dispatcher object
+ * @sigmask: set of signals to be blocked while waiting
+ *
+ * This function waits for events or timeouts to occur, and calls
+ * callbacks as appropriate. A single epoll_wait() call is made.
+ * Depending on how the code was compiled, 0, 1, or more events may
+ * occur in a single call. While waiting, the signal mask will be
+ * set to @sigmask atomically. It is recommended to block all signals
+ * except those that the application wants to receive (e.g. SIGTERM),
+ * and install a signal handler for these signals to avoid the default
+ * action (usually program termination, see signal(7)).
+ *
+ * NOTE: if no events have been added to the dispatcher before calling this
+ * function, it will block waiting until a signal is caught.
+ *
+ * Return: 0 on success, a negative error code (-errno) on failure,
+ * which might be -EINTR.
+ */
+int event_wait(const struct dispatcher *dsp, const sigset_t *sigmask);
+
+/**
+ * Return codes for err_handler in event_loop()
+ */
+enum {
+	ELOOP_CONTINUE = 0,
+	ELOOP_QUIT,
+};
+
+/**
+ * event_loop(): wait for some or timeouts, repeatedly
+ *
+ * @dispatcher: a dispatcher object
+ * @sigmask: set of signals to be blocked while waiting
+ * @err_handler: callback for event_wait
+ *
+ * This function calls event_wait() in a loop, and calls err_handler() if
+ * event_wait() returns an error code, passing it the negative error code
+ * (e.g. -EINTR) in the @err parameter. err_handler() should return ELOOP_QUIT
+ * or a negative error code to make event_loop() return, and ELOOP_CONTINUE
+ * if event_loop() should continue execution.
+ * @err_handler may be NULL, in which case event_loop() will simply return
+ * the error code from event_wait().
+ *
+ * Return: 0 on success, or negative error code (-errno) on failure.
+ * In particular, it returns -EINTR if interrupted by caught signal.
+ */
+int event_loop(const struct dispatcher *dsp, const sigset_t *sigmask,
+	       int (*err_handler)(int err));
+
+/**
+ * cleanup_dispatcher() - clean out all events and timeouts
+ * @dsp: a pointer returned by new_dispatcher().
+ *
+ * Remove all events and timeouts, and call every event's @cleanup
+ * callback. The dispatcher object itself remains intact, and can
+ * be re-used by adding new events.
+ *
+ * NOTE: unlike free_dispatcher(), this function disables the timer
+ * event (as it cancels all timeouts), and removes all fds from the
+ * dispatcher's epoll instance. Thus calling this e.g. after fork()
+ * affects the parent process's operation.
+ *
+ * Return: 0 on success, negative error code (-errno) on failure.
+ */
+int cleanup_dispatcher(struct dispatcher *dsp);
+
+/**
+ * free_dispatcher() - free a dispatcher object.
+ * @dsp: a pointer returned by new_dispatcher().
+ *
+ * Calls the @cleanup callback of every registered event, and frees
+ * the dispatcher's data structures.
+ *
+ * NOTE: Unlike cleanup_dispatcher(), this function doesn't touch the
+ * kernel-owned epoll and itimerfd data structures. It's safe to call after
+ * fork() without disturbing the parent.
+ */
+void free_dispatcher(struct dispatcher *dsp);
+
+/**
+ * new_dispatcher() - allocate and return a new dispatcher object.
+ *
+ * @clocksrc: one of the supported clock sources of the system,
+ *            see clock_gettime(2). It will be used for timeout handling.
+ *
+ * Return: NULL on failure, a valid pointer otherwise.
+ */
+struct dispatcher *new_dispatcher(int clocksrc);
+
+/**
+ * dispatcher_get_efd() - obtain the epoll file descriptor
+ *
+ * @dispatcher: a dispatcher object
+ *
+ * Use this function if you want to implement a custom wait loop, to
+ * obtain the file descriptor to be passed to epoll_wait().
+ */
+int dispatcher_get_efd(const struct dispatcher *dsp);
+
+/**
+ * dispatcher_get_clocksource() - obtain the clock source used for timeouts
+ *
+ * @dispatcher: a dispatcher object
+ * *
+ * Return: the clocksrc passed to new_dispatcher when the object was
+ * created.
+ */
+int dispatcher_get_clocksource(const struct dispatcher *dsp);
+
+/**
+ * Convenenience macros for event initialization
+ *
+ * IMPORTANT: The cleanup functionality of the ON_HEAP variants requires
+ * that "struct event" is embedded in the application's data structures
+ * at offset 0.
+ */
+
+/**
+ * __EVENT_INIT() - generic timer initializer
+ */
+#define __EVENT_INIT(cb, cln, f, ev, s, ns)		\
+	((struct event){				\
+		.fd = (f),				\
+		.ep.events = (ev),			\
+		.callback = (cb),			\
+		.cleanup = (cln),			\
+		.tmo.tv_sec  = (s),			\
+		.tmo.tv_nsec = (ns),			\
+	})
+
+/**
+ * EVENT_W_TMO_ON_STACK() - initializer for struct event
+ * @cb: callback of type @cb_fn
+ * @f:  file descriptor
+ * @ev: epoll event mask
+ * @us: timeout in microseconds, must be non-negative
+ */
+#define EVENT_W_TMO_ON_STACK(cb, f, ev, us)			\
+	__EVENT_INIT(cb, cleanup_event_on_stack, f, ev,		\
+		     (us) / 1000000L, (us) % 1000000L * 1000)
+
+/**
+ * EVENT_ON_STACK() - initializer for struct event
+ * @cb: callback of type @cb_fn
+ * @f:  file descriptor
+ * @ev: epoll event mask
+ *
+ * The initialized event has no timeout.
+ */
+#define EVENT_ON_STACK(cb, f, ev) \
+	EVENT_W_TMO_ON_STACK(cb, f, ev, 0)
+
+/**
+ * TIMER_EVENT_ON_STACK() - initializer for struct event
+ * @cb: callback of type @cb_fn
+ * @us: timeout in microseconds, must be non-negative
+ * NOTE: it's pointless to set a timeout of 0 us (timer inactive),
+ *       thus the code sets it to 1ns at least.
+ * Thus, by passing us = 0, an event is created that will fire
+ * immediately after calling event_wait() or event_loop().
+ */
+#define TIMER_EVENT_ON_STACK(cb, us)				\
+	__EVENT_INIT(cb, cleanup_event_on_stack, -1, 0,		\
+		     (us) / 1000000L, (us) % 1000000L * 1000 + 1)
+
+/**
+ * EVENT_W_TMO_ON_HEAP() - initializer for struct event
+ * Like EVENT_W_TMO_ON_STACK(), but the cleanup callback
+ * will free the struct event.
+ */
+#define EVENT_W_TMO_ON_HEAP(cb, f, ev, us)			\
+	__EVENT_INIT(cb, cleanup_event_on_heap, f, ev,		\
+		     (us) / 1000000L, (us) % 1000000L * 1000)
+
+/**
+ * EVENT_ON_HEAP() - initializer for struct event
+ * Like EVENT_ON_STACK(), but the cleanup callback
+ * will free the struct event.
+ */
+#define EVENT_ON_HEAP(cb, f, ev)			\
+	EVENT_W_TMO_ON_HEAP(cb, f, ev, 0)
+
+/**
+ * TIMER_EVENT_ON_HEAP() - initializer for struct event
+ * Like TIMER_EVENT_ON_STACK(), but the cleanup callback
+ * will free the struct event.
+ */
+#define TIMER_EVENT_ON_HEAP(cb, us)				\
+	__EVENT_INIT(cb, cleanup_event_on_heap, -1, 0,		\
+		     (us) / 1000000L, (us) % 1000000L * 1000 + 1)
+
+/**
+ * timer_cb - prototype for a generic single-shot timer callback
+ * Use the TIMER macros below.
+ */
+typedef void (*timer_cb)(void *arg);
+
+/**
+ * _call_timer_cb() - helper for invoking timer callbacks
+ *
+ * Internal use.
+ */
+int _call_timer_cb(struct event *, uint32_t events);
+
+/**
+ * struct timer_event - helper struct for invoking timer callbacks
+ */
+struct timer_event {
+	struct event e;
+	timer_cb timer_fn;
+	void *timer_arg;
+};
+
+/**
+ * TIMER_ON_STACK() - initializer for a single-shot timer
+ * @fn: callback of type @timer_cb
+ * @arg: argument to pass to @fn
+ * @us: timeout in microseconds
+ */
+#define TIMER_ON_STACK(fn, arg, us)					\
+	((struct timer_event){						\
+		.e = TIMER_EVENT_ON_STACK(_call_timer_cb, us),		\
+		.timer_fn = fn,						\
+		.timer_arg = arg,					\
+	})
+
+/**
+ * TIMER_ON_HEAP() - initializer for a single-shot timer
+ * Like TIMER_ON_STACK(), but the cleanup callback
+ * will free the struct event.
+ */
+#define TIMER_ON_HEAP(fn, arg, us)					\
+	((struct timer_event){						\
+		.e = TIMER_EVENT_ON_HEAP(_call_timer_cb, us),		\
+		.timer_fn = fn,						\
+		.timer_arg = arg,					\
+	})
+
+#endif
diff --git a/event/timeout.c b/event/timeout.c
new file mode 100644
index 0000000..ee37b30
--- /dev/null
+++ b/event/timeout.c
@@ -0,0 +1,373 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#include <inttypes.h>
+#include <limits.h>
+#include <stddef.h>
+#include <stdbool.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <time.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/timerfd.h>
+#include <syslog.h>
+#include "common.h"
+#include "ts-util.h"
+#define LOG_FUNCNAME 1
+#include "log.h"
+#include "timeout.h"
+#include "event.h"
+
+struct timeout_handler {
+        int source;
+        size_t len;
+        struct timespec **timeouts;
+	struct timespec expiry;
+	struct event ev;
+};
+
+int timeout_get_clocksource(const struct event *evt)
+{
+	return container_of_const(evt, struct timeout_handler, ev)->source;
+}
+
+static void free_timeout_handler(struct timeout_handler *th)
+{
+        if (th->ev.fd != -1)
+                close(th->ev.fd);
+
+        if (th->timeouts)
+                free(th->timeouts);
+
+        free(th);
+}
+
+void free_timeout_event(struct event *ev)
+{
+	return free_timeout_handler(container_of(ev, struct timeout_handler, ev));
+}
+
+struct event *new_timeout_event(int source)
+{
+        struct timeout_handler *th = calloc(1, sizeof(*th));
+
+        if (!th)
+                return NULL;
+        th->ev.fd = timerfd_create(source, TFD_NONBLOCK|TFD_CLOEXEC);
+        if (th->ev.fd == -1) {
+                msg(LOG_ERR, "timerfd_create: %m\n");
+                free(th);
+                return NULL;
+        }
+        th->source = source;
+	th->ev.ep.events = EPOLLIN;
+	th->ev.ep.data.ptr = &th->ev;
+	th->ev.callback = timeout_event;
+
+	msg(LOG_DEBUG, "done\n");
+        return &th->ev;
+}
+
+static long _timeout_rearm(struct timeout_handler *th, long pos)
+{
+        struct itimerspec it = { .it_interval = { 0, 0 }, };
+        int rc;
+
+        if (pos < (long)th->len)
+                it.it_value = *th->timeouts[pos];
+
+	if (ts_compare(&it.it_value, &th->expiry) == 0)
+		return pos;
+
+        msg(LOG_DEBUG, "current: %ld/%zd, expire: %ld.%06ld\n",
+            pos, th->len, (long)it.it_value.tv_sec, it.it_value.tv_nsec / 1000L);
+
+        rc = timerfd_settime(th->ev.fd, TFD_TIMER_ABSTIME, &it, NULL);
+        if (rc == -1) {
+                msg(LOG_ERR, "timerfd_settime: %m\n");
+                return -errno;
+        } else {
+		th->expiry = it.it_value;
+                return pos;
+	}
+}
+
+static const struct timespec null_ts;
+
+static long timeout_resize(struct timeout_handler *th, size_t size)
+{
+	struct timespec **tmp;
+
+	if (size > LONG_MAX)
+		return -EOVERFLOW;
+
+	if (size == 0) {
+		free(th->timeouts);
+		th->timeouts = NULL;
+		th->len = 0;
+		return 0;
+	}
+
+	msg(LOG_DEBUG, "size old %zu new %zu\n", th->len, size);
+	tmp = realloc(th->timeouts, size * sizeof(*th->timeouts));
+	if (tmp == NULL)
+		return -errno;
+
+	th->timeouts = tmp;
+	return size;
+}
+
+int timeout_reset(struct event  *tmo_event)
+{
+	struct timeout_handler *th =
+		container_of(tmo_event, struct timeout_handler, ev);
+
+	timeout_resize(th, 0);
+	return _timeout_rearm(th, 0);
+}
+
+static int absolute_timespec(int source, struct timespec *ts)
+{
+	struct timespec now;
+
+	if (clock_gettime(source, &now) == -1)
+		return -errno;
+	ts->tv_sec += now.tv_sec;
+	ts->tv_nsec += now.tv_nsec;
+	return 0;
+}
+
+static int timeout_add_ev(struct timeout_handler *th, struct event *event)
+{
+        long pos;
+	int rc;
+
+        if (!th || !event)
+                return -EINVAL;
+
+	if (ts_compare(&event->tmo, &null_ts) == 0)
+		return 0;
+
+	for (pos = 0; pos < (long)th->len; pos++)
+		if (th->timeouts[pos] == &event->tmo) {
+			msg(LOG_DEBUG, "event %p exists already at pos %ld/%zu\n",
+			    event, pos, th->len);
+			return -EEXIST;
+		};
+
+	if ((rc = timeout_resize(th, th->len + 1)) < 0) {
+		msg(LOG_ERR, "failed to increase array size: %m\n");
+		return rc;
+	}
+
+        if (~event->flags & TMO_ABS &&
+	    absolute_timespec(th->source, &event->tmo) == -1)
+			return -errno;
+
+        pos = ts_insert(th->timeouts, &th->len, th->len + 1, &event->tmo);
+        if (pos < 0) {
+                msg(LOG_ERR, "ts_insert failed: %m\n");
+                return errno ? -errno : -EIO;
+        }
+
+        msg(LOG_DEBUG, "new timeout at pos %ld/%zd: %ld.%06ld\n",
+            pos, th->len, (long)event->tmo.tv_sec, event->tmo.tv_nsec / 1000L);
+
+        if (pos == 0)
+                _timeout_rearm(th, pos);
+
+        return 0;
+}
+
+int timeout_add(struct event *tmo_event, struct event *ev)
+{
+	return timeout_add_ev(container_of(tmo_event, struct timeout_handler, ev), ev);
+}
+
+static int timeout_cancel_ev(struct timeout_handler *th, struct event *evt)
+{
+        struct timespec *ts = &evt->tmo;
+        long pos;
+
+	if (ts_compare(&evt->tmo, &null_ts) == 0)
+		return 0;
+
+        for (pos = 0; pos < (long)th->len && ts != th->timeouts[pos]; pos++);
+
+        if (pos == (long)th->len) {
+                msg(LOG_DEBUG, "%p: not found\n", evt);
+		/*
+		 * This is normal if called from a timeout handler.
+		 * Mark the event as having no timeout.
+		 */
+		*ts = null_ts;
+                return -ENOENT;
+        }
+
+	msg(LOG_DEBUG, "timeout %ld cancelled, %ld.%06ld\n",
+            pos, (long)ts->tv_sec, ts->tv_nsec / 1000L);
+
+	*ts = null_ts;
+        memmove(&th->timeouts[pos], &th->timeouts[pos + 1],
+                (th->len - pos - 1) * sizeof(*th->timeouts));
+
+        th->len--;
+        if (pos == 0)
+                _timeout_rearm(th, 0);
+        return 0;
+}
+
+int timeout_cancel(struct event *tmo_event, struct event *ev)
+{
+	return timeout_cancel_ev(container_of(tmo_event, struct timeout_handler, ev), ev);
+}
+
+int timeout_modify(struct event *tmo_event, struct event *evt, struct timespec *new)
+{
+	struct timeout_handler *th =
+		container_of(tmo_event, struct timeout_handler, ev);
+        struct timespec *ts = &evt->tmo;
+        long pos, pnew, pmin;
+
+	if (ts_compare(&evt->tmo, &null_ts) == 0 || th->len == 0) {
+		evt->tmo = *new;
+		return timeout_add_ev(th, evt);
+	}
+
+	if (ts_compare(new, &null_ts) == 0)
+		return timeout_cancel_ev(th, evt);
+
+	if (ts_compare(new, &evt->tmo) == 0)
+		/* Nothing changed */
+		return 0;
+
+	/* There could be several timeouts with the same expiry, find the right one */
+	pmin = ts_search(th->timeouts, th->len, ts);
+        for (pos = pmin;
+             pos < (long)th->len &&
+                     ts_compare(th->timeouts[pos], ts) == 0;
+             pos++) {
+                if (ts == th->timeouts[pos])
+                        break;
+        }
+
+        if (pos == (long)th->len || ts != th->timeouts[pos]) {
+		/* This is normal if timeout_modify called from timeout handler */
+                msg(LOG_DEBUG, "%p: not found\n", evt);
+                evt->tmo = *new;
+		return timeout_add_ev(th, evt);
+        }
+
+        if (~evt->flags & TMO_ABS && absolute_timespec(th->source, new) == -1)
+		return -errno;
+
+	ts_normalize(new);
+	pnew = ts_search(th->timeouts, th->len, new);
+	if (pnew < 0)
+		return pnew;
+
+	if (pnew > pos + 1) {
+		/*
+		 * ts_search returns the position (pnew) at which the new tmo would be
+		 * inserted. All members at pnew or higher are >= new.
+		 * So if pnew = pos + 1, nothing needs to be done.
+		 * Subtract 1, because pnew is after pos but pos will be moved away.
+		 */
+		pnew--;
+		memmove(&th->timeouts[pos], &th->timeouts[pos + 1],
+			(pnew - pos)  * sizeof(*th->timeouts));
+		th->timeouts[pnew] = &evt->tmo;
+	} else if (pnew < pos) {
+		memmove(&th->timeouts[pnew + 1], &th->timeouts[pnew],
+			(pos - pnew)  * sizeof(*th->timeouts));
+		th->timeouts[pnew] = &evt->tmo;
+	}
+	msg(LOG_DEBUG, "timeout %ld now at pos %ld, %ld.%06ld -> %ld.%06ld\n",
+            pos, pnew, (long)ts->tv_sec, ts->tv_nsec / 1000L,
+            (long)new->tv_sec, new->tv_nsec / 1000L);
+	evt->tmo = *new;
+
+
+        if (pnew == 0)
+                _timeout_rearm(th, 0);
+        return 0;
+}
+
+static void _timeout_run_callbacks(struct timespec **tss, long n)
+{
+        long i;
+
+        for (i = 0; i < n; i++) {
+                struct event *evt;
+
+                evt = container_of(tss[i], struct event, tmo);
+
+                msg(LOG_DEBUG, "calling callback %ld (%ld.%06ld)\n", i,
+                    (long)tss[i]->tv_sec, tss[i]->tv_nsec / 1000);
+
+		_event_invoke_callback(evt, REASON_TIMEOUT, 0, true);
+        }
+
+}
+
+int timeout_event(struct event *tmo_ev, uint32_t events)
+{
+	struct timeout_handler *th = container_of(tmo_ev, struct timeout_handler, ev);
+        struct timespec now;
+        struct timespec **expired;
+        long pos = th->len;
+	uint64_t val;
+
+	if (tmo_ev->reason != REASON_EVENT_OCCURED || events & ~EPOLLIN) {
+		msg(LOG_WARNING, "unexpected reason %s, events 0x%08x\n",
+		    reason_str[tmo_ev->reason], events);
+		return EVENTCB_CONTINUE;
+	}
+
+	if (read(tmo_ev->fd, &val, sizeof(val)) == -1)
+		/*
+		 * EAGAIN happens if the most recent timer was cancelled
+		 * and the timer rearmed before we get here.
+		 */
+		msg(errno == EAGAIN ? LOG_DEBUG : LOG_ERR,
+		    "failed to read timerfd: %m\n");
+
+	clock_gettime(th->source, &now);
+
+        /*
+         * callbacks may add new timers, therefore we must iterate here.
+         */
+        while (th->len > 0) {
+
+		/* Expired timeouts are at the beginning, don't ts_search() here */
+		for (pos = 0;
+		     pos < (long)th->len && ts_compare(th->timeouts[pos], &now) <= 0;
+		     pos++);
+
+                if (pos == (long)th->len) {
+                        expired = th->timeouts;
+                        th->len = 0;
+                        th->timeouts = NULL;
+                        _timeout_run_callbacks(expired, pos);
+                        free(expired);
+                } else if (pos > 0) {
+                        expired = malloc(pos * sizeof(*expired));
+                        if (expired)
+                                memcpy(expired, th->timeouts, pos * sizeof(*expired));
+                        th->len -= pos;
+                        memmove(th->timeouts, &th->timeouts[pos],
+                                th->len * sizeof(*th->timeouts));
+                        if (expired) {
+                                _timeout_run_callbacks(expired, pos);
+                                free(expired);
+                        }
+                } else
+                        break;
+        }
+
+        _timeout_rearm(th, 0);
+	return EVENTCB_CONTINUE;
+}
diff --git a/event/timeout.h b/event/timeout.h
new file mode 100644
index 0000000..fd87eae
--- /dev/null
+++ b/event/timeout.h
@@ -0,0 +1,110 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#ifndef _TIMEOUT_H
+#define _TIMEOUT_H
+
+struct event;
+
+/**
+ * free_timeout_event() - free resources associated with a timeout event
+ * @tmo_event: a struct event returned from new_timeout_event().
+ */
+void free_timeout_event(struct event *tmo_event);
+
+/**
+ * new_timeout_event() - create a new timeout event object
+ * @source: One of the supported clock sources of the sytstem, see clock_gettime(2).
+ *
+ * Return: a new timeout event object on success, NULL on failure.
+ */
+struct event *new_timeout_event(int source);
+
+/**
+ * timeout_add() - add an event to the timeout list.
+ * @tmo_event: struct event returned from new_timeout_event().
+ * @event: a struct event
+ *
+ * This function adds @event to the list of timeouts handled, using
+ * the @event->tmo and @event->flags to determine the expiry of the timeout.
+ * When the timeout expires, timeout_event() will call @event->callback()
+ * with @event->reason set to @REASON_TIMEOUT.
+ * If @event->tmo is {0, 0}, nothing is done.
+ *
+ * Return: 0 on success. On error, a negative error code.
+ *  -EEXIST: the event is already in the list of timeouts handled.
+ *  -ENOMEM: failed to allocate memory to insert the new element.
+ *  -EINVAL: invalid input parameters.
+ */
+int timeout_add(struct event *tmo_event, struct event *event);
+
+/**
+ * timeout_modify() - modify the timeout value of a previously added event
+ * @tmo_event: struct event returned from new_timeout_event().
+ * @event: the event to modify
+ * @new: the new timeout (doesn't need to be normalized)
+ *
+ * Moves the event in the timeout list to a new position according to
+ * the new timeout value in @new. If the event isn't currently in the list,
+ * timeout_add() will be called. If @new is {0, 0} (no timeout), timeout_cancel()
+ * is called. On successful return, @event->tmo will be set
+ * to @new, and normalized.
+ * IMPORTANT: don't set @event->tmo to @new before calling this function.
+ *
+ * Return: 0 on success, negative error code on failure. Error codes can be
+ * from timeout_add() or timeout_cancel().
+ */
+int timeout_modify(struct event *tmo_event, struct event *event, struct timespec *new);
+
+/**
+ * timeout_cancel() - remove an event from the timeout list
+ * @tmo_event: struct event returned from new_timeout_event().
+ * @event: the event to modify
+ *
+ * Subsequent calls to timeout_event() will not call this event's callback any more.
+ * But if the timeout event has already happened and delivered to the event dispatcher,
+ * this function will return -ENOENT, and the callback will be called later on.
+ *
+ * Return: 0 on success, negative error code on failure.
+ *  -ENOENT: the event wasn't found in the timeout list. Either the timeout event
+ *  had happened already, or the event had never been added / already cancelled.
+ */
+int timeout_cancel(struct event *tmo_event, struct event *);
+
+/**
+ * timeout_reset() - clear all timeouts
+ *
+ * Cancel all timeouts (without calling any callbacks), and disarm the timer.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int timeout_reset(struct event *tmo_event);
+
+/**
+ * timeout_event() - handle timeout events
+ * @tmo_event: struct event returned from new_timeout_event().
+ * @events: epoll event bitmask, see epoll_wait(2); expected to be EPOLLIN.
+ *
+ * This function is invoked by the event dispatcher if the @tmo_event has occured,
+ * meaning that one or more timeouts in the list handled by @tmo_ev have expired.
+ * timeout_event() removes the expired events from the list and calls the respective
+ * callbacks for the timed-out events with the @reason field set to @REASON_TIMEOUT.
+ *
+ * If the callback wants to extend or otherwise re-arm the timeout, it must call
+ * timeout_add() or (preferrably) timeout_modify().
+ *
+ * Return: EVENTCB_CONTINUE
+ */
+int timeout_event(struct event *tmo_event, uint32_t events);
+
+/**
+ * timeout_get_clocksource() - obtain clock source used
+ * @tmo_event: struct event returned from new_timeout_event().
+ *
+ * Return: the clock source passed to new_timeout_event() when @tmo_ev
+ * was created.
+ */
+int timeout_get_clocksource(const struct event *tmo_event);
+
+#endif
diff --git a/event/ts-util.c b/event/ts-util.c
new file mode 100644
index 0000000..2cb1466
--- /dev/null
+++ b/event/ts-util.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#include <time.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <limits.h>
+#include <errno.h>
+#include "ts-util.h"
+void ts_normalize(struct timespec *tv)
+{
+	long quot, rem;
+	if (tv->tv_nsec >= 0 && tv->tv_nsec < 1000000000L)
+		return;
+	quot = tv->tv_nsec / 1000000000L;
+	rem = tv->tv_nsec % 1000000000L;
+	if (rem < 0) {
+		rem += 1000000000L;
+		quot--;
+	}
+	tv->tv_sec += quot;
+	tv->tv_nsec = rem;
+}
+
+void ts_add(struct timespec *t1, const struct timespec *t2)
+{
+	t1->tv_sec += t2->tv_sec;
+	t1->tv_nsec += t2->tv_nsec;
+	ts_normalize(t1);
+	return;
+}
+
+void ts_subtract(struct timespec *t1, const struct timespec *t2)
+{
+	t1->tv_sec -= t2->tv_sec;
+	t1->tv_nsec -= t2->tv_nsec;
+	ts_normalize(t1);
+	return;
+}
+
+int ts_compare(const struct timespec *t1, const struct timespec *t2)
+{
+	if (t1->tv_sec < t2->tv_sec)
+		return -1;
+	if (t1->tv_sec > t2->tv_sec)
+		return 1;
+	if (t1->tv_nsec < t2->tv_nsec)
+		return -1;
+	if (t1->tv_nsec > t2->tv_nsec)
+		return 1;
+	return 0;
+}
+
+static int ts_compare_q(const struct timespec **pt1,
+			const struct timespec **pt2)
+{
+	return ts_compare(*pt1, *pt2);
+}
+
+long ts_search(struct timespec *const *tvs, size_t size, struct timespec *new)
+{
+	long low, high, mid;
+	if (!new || !tvs || size > LONG_MAX)
+		return -EINVAL;
+	ts_normalize(new);
+	if (size == 0)
+		return 0;
+	high = size - 1;
+	if (ts_compare(new, tvs[high]) > 0)
+		return size;
+	low = 0;
+	while (high - low > 1) {
+		mid = low + (high - low) / 2;
+		if (ts_compare(new, tvs[mid]) <= 0)
+			high = mid;
+		else
+			low = mid;
+	}
+	if (high > low && ts_compare(new, tvs[low]) > 0)
+		return high;
+	else
+		return low;
+}
+
+long ts_insert(struct timespec **tvs, size_t *len, size_t size,
+	       struct timespec *new)
+{
+	long pos;
+	if (!len || size <= *len)
+		return -EOVERFLOW;
+	pos = ts_search(tvs, *len, new);
+	if (pos < 0)
+		return pos;
+	memmove(&tvs[pos + 1], &tvs[pos], (*len - pos) * sizeof(*tvs));
+	(*len)++;
+	tvs[pos] = new;
+	return pos;
+}
+
+void ts_sort(struct timespec **tvs, size_t size)
+{
+	qsort(tvs, size, sizeof(struct timespec *),
+	      (int (*)(const void *, const void *))ts_compare_q);
+	return;
+}
diff --git a/event/ts-util.h b/event/ts-util.h
new file mode 100644
index 0000000..1b469f0
--- /dev/null
+++ b/event/ts-util.h
@@ -0,0 +1,129 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#ifndef _TS_UTIL_H
+#define _TS_UTIL_H
+
+/*
+ * Utility functions for dealing with "struct timespec".
+ * See also tv_util.h, which has the same set of functions
+ * for "struct timeval".
+ */
+
+/**
+ * ts_to_us - convert struct timespec to microseconds
+ * @ts: timespec object
+ *
+ * Return: value of @ts in microseconds.
+ */
+static inline uint64_t ts_to_us(const struct timespec *ts)
+{
+	return ts->tv_sec * 1000000ULL + ts->tv_nsec / 1000;
+}
+
+/**
+ * us_to_ts - convert microseconds to struct timespec
+ * @us: microseconds
+ * @ts: conversion result
+ */
+static inline void us_to_ts(uint64_t us, struct timespec *ts)
+{
+	ts->tv_sec = us / 1000000L;
+	ts->tv_nsec = (us % 1000000L) * 1000;
+}
+
+/**
+ * ts_normalize() - convert a struct timespec to normal form
+ * @ts: timespec to normalize
+ *
+ * "Normalized" means 0 <= ts->tv_nsec < 1000000000.
+ */
+void ts_normalize(struct timespec *ts);
+
+/**
+ * ts_add(): add a struct timespec to another
+ * @t1: 1st summand, this one will be modified
+ * @t2: 2nd summand, will be added to @t1.
+ *
+ * @t1 is normalized on return.
+ */
+void ts_add(struct timespec *t1, const struct timespec *t2);
+
+/**
+ * ts_subtract(): subtract a struct timespec from another
+ *
+ * @t1: minuend, this one will be modified
+ * @t2: subtrahend
+ *
+ * @t1 is normalized on return.
+ */
+void ts_subtract(struct timespec *t1, const struct timespec *t2);
+
+/**
+ * ts_compare - compare two struct timespec objects
+ *
+ * @t1: 1st timespec object
+ * @t2: 2nd timespec object
+ *
+ * IMPORTANT: this function assumes that both @t1 and  @t2 are normalized.
+ * If that's not the case, results will be wrong.
+ *
+ * Return: 0 if @t1 == @t2, -1 if @t1 < @t2 and 1 if @t1 > @t2.
+ */
+int ts_compare(const struct timespec *t1, const struct timespec *t2);
+
+/**
+ * ts_sort() - sort an array of normalized struct timespec objects
+ *
+ * @tss: array of of "struct timespec *"
+ * @len: number of elements in @tss
+ *
+ * IMPORTANT: all elements of the array should be normalized before calling
+ * this function.
+ * The array is sorted in ascending order, using ts_compare() for comparing
+ * elements.
+ */
+void ts_sort(struct timespec **tss, size_t len);
+
+/**
+ * ts_search - find insertion point for a timespec object in a sorted array
+ *
+ * @tvs: sorted array of normalized "struct timespec *"
+ * @len: number of elements in @tss
+ * @new: new struct timespec object
+ *
+ * On entry, @tvs must be a sorted array of normalized "struct timespec" pointers.
+ * (sorted in the sense of ts_sort()). The function searches the index in the
+ * array where @new would need to be inserted, using a bisection algorithm.
+ * @new needs not be normalized on entry, it will be when the function returns
+ * successfully.
+ *
+ * Return: On success, the non-negative index at which this element would need to
+ * be inserted in the array in order to keep it sorted. If the return value is n,
+ * then the timespec @tvs[n-1] is smaller than @new, and @tvs[n] is greater or
+ * equal than @new.
+ *  -EINVAL if one of the input parameters is invalid.
+ */
+long ts_search(struct timespec *const *tvs, size_t len, struct timespec *new);
+
+/**
+ * ts_insert - insert a new struct timespec into a sorted array
+ *
+ * @tvs: sorted array of normalized "struct timespec *"
+ * @len: number of elements in @tss
+ * @size: allocated size (in elements) of @tvs, must be larger than @len on entry
+ * @new: new struct timespec object
+ *
+ * Inserts the element @new into @tvs at the point returned by ts_search(), keeping
+ * the array sorted. @new doesn't need to be normalized on entry, it will be on
+ * successful return.
+ * This function doesn't reallocate @tvs and doesn't take a copy of @new.
+ *
+ * Return: On success, the non-negative index at which the element was inserted.
+ *  -EINVAL if input parameters were invalid (see ts_search()).
+ *  -EOVERFLOW if @size is not large enough to add the new element.
+ */
+long ts_insert(struct timespec **tvs, size_t *len, size_t size, struct timespec *new);
+
+#endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
