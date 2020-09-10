Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4327C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 04:35:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5888B20732
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 04:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zzqRIs49";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnAXw6mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5888B20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:Message-ID:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=x1lQJUIIRfiym8EAcj7O61Sngs96Iors7BQHzqNkRTs=; b=zzqRIs49S17ziwe6O9yerfhNs
	YWDA5jDEEZEBQUgxFFXLsoJJdBgiNY6ta2RUMedFilQGNzxItxFdLE+M0B8ZibQtTK2bx+PsavSxd
	giXleaDGYtoI5M+9JCz520XfyBqx0ERxL3g1xXymBOonz9QaINqlfiLWqrrvD5t6Wyg0TvIV7YRZk
	lckBwjV9dm56d7OFaQPx9Eq8NlkhQPjBu7ORRzjJ+RBsi5m4glvgKTRG5BzJk5cEV/T6cEhFwGWPW
	xehmn1vIuIv/A8aZSMoPp1PMPwrwMBb+1TDCtwrOvbsi+21EXJbbGzcXL3ko4HZiBeYftDl2vYmhF
	mb6t2IlyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGEJ4-0005XV-Sr; Thu, 10 Sep 2020 04:35:34 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGEJ1-0005V1-7W
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 04:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599712529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=Rk6lA1q1+QkQVcteFZtSE71LJm51shL/v0+mk7oaEak=;
 b=YnAXw6mKIe67v7vgqGejH0h0tUKEJpSrQmh3FVDrFaLkUSokLDhb16wEUikB+SG2o3h1rd
 +5ihqiyi4yMx1XS+y1MQSv7RSr1hrjWG7QSnve7sE75trU4EShUzRYm8G+IsjeQ86C7sY+
 O3UjDOEFw+V5dcujqcCQjgS5zt0I3FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-3baqMv2gPi-hQu_MWeZfow-1; Thu, 10 Sep 2020 00:35:20 -0400
X-MC-Unique: 3baqMv2gPi-hQu_MWeZfow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE8B41007467;
 Thu, 10 Sep 2020 04:35:19 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C615D3A40;
 Thu, 10 Sep 2020 04:35:19 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id B80D779DBA;
 Thu, 10 Sep 2020 04:35:19 +0000 (UTC)
Date: Thu, 10 Sep 2020 00:35:18 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: sagi@grimberg.me, gscrivan@redhat.com, colin.king@canonical.com
Message-ID: <643455136.711850.1599712518936.JavaMail.zimbra@redhat.com>
In-Reply-To: <1594444669.711245.1599710442490.JavaMail.zimbra@redhat.com>
Subject: nvme_tcp: nvme connect failed after execute stress-ng: unshare
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.5]
Thread-Topic: nvme_tcp: nvme connect failed after execute stress-ng: unshare
Thread-Index: bsGVWsFjDOgJz2iMBcDCCN7UZKl0xQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_003531_302322_2E0471D7 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

Recently I found nvme-tcp connecting always failed[1] after execute stress-ng:unshare[2], by bisecting I finally found it was introduced with commit[3], the connecting works well after revert it.
I'm not sure whether it's one test case issue or kernel issue, could anyone help check it.

[1]
# sh test.sh 
+ ./stress-ng/stress-ng --unshare 0 --timeout 5 --log-file unshare.log
stress-ng: info:  [355534] dispatching hogs: 32 unshare
stress-ng: info:  [355534] successful run completed in 5.04s
+ modprobe null-blk nr-devices=1
+ modprobe nvmet-tcp
+ modprobe nvme-tcp
+ nvmetcli restore tcp.json
+ nvme connect -t tcp -n nqn.2014-08.org.nvmexpress.discovery -a 127.0.0.1 -s 4420
Failed to write to /dev/nvme-fabrics: Input/output error

# dmesg | tail -9
[  700.012299] null_blk: module loaded
[  700.073415] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  700.073923] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  715.291020] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[  715.297031] nvmet: ctrl 1 fatal error occurred!
[  749.939898] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:e405e6bb-8e28-4a73-b338-3fddb5746b8c.
[  763.417376] nvme nvme0: queue 0: timeout request 0x0 type 4
[  763.422979] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[  763.429419] nvme nvme0: failed to connect queue: 0 ret=881

# uname -r
5.9.0-rc4


[2] stress-ng: unshare case
https://github.com/ColinIanKing/stress-ng.git
https://github.com/ColinIanKing/stress-ng/blob/master/stress-unshare.c


[3] 
commit e1eb26fa62d04ec0955432be1aa8722a97cb52e7
Author: Giuseppe Scrivano <gscrivan@redhat.com>
Date:   Sun Jun 7 21:40:10 2020 -0700

    ipc/namespace.c: use a work queue to free_ipc
    
    the reason is to avoid a delay caused by the synchronize_rcu() call in
    kern_umount() when the mqueue mount is freed.


[4]
# cat tcp.json 
{
  "hosts": [],
  "ports": [
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "127.0.0.1",
        "treq": "not specified",
        "trsvcid": "4420",
        "trtype": "tcp"
      },
      "portid": 0,
      "referrals": [],
      "subsystems": [
        "blktests-subsystem-1"
      ]
    }
  ],
  "subsystems": [
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1",
        "cntlid_max": "65519",
        "cntlid_min": "1",
        "model": "Linux",
        "pi_enable": "0",
        "serial": "7d833f5501f6b240",
        "version": "1.3"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nullb0",
            "uuid": "b07c7eef-8428-47bf-8e79-26ec8c30f334"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "blktests-subsystem-1"
    }
  ]
}


Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
