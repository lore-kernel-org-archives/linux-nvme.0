Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D7C4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 21:37:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEBC20658
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qc8Xw0wm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yeh2Wmht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEBC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:
	Subject:From:To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j7kKE/gX7zpJd+M5dfVjNJc46xslRB/HtfDKx/ZtJUE=; b=qc8Xw0wm6Gyvoo
	oZiVdbFoDMBVT/RKOTxP9MdGclnAPdRtg/PYwv7kljhFxgQI6hi/8yQZ/mbUbiD3RSfo5AjmcaDTW
	NETz0Q3krrz6Iv5pJNI+2gADh8ju1Dv/JLq1pt5BAWlO8bN5bQ0iukYiYS9LbuWP9XtET8ZBPP8KQ
	UdEUKRqvwn0Ruyj7QXdkxmkSAfOAH8zIXOSxN88SrsBIgToON2L6qK0qBWV6F2hk/YblLoyDlbFLu
	vYqCrImz069j7pb5NYPwthFpmrKkwspYaFrMJ9zeSh2ecyZIACjREv2B/k/nS4H5KEdv5EhuHrK2x
	hQvdWnv9zQ/GkGUO6qjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFPKB-00044X-JR; Fri, 20 Mar 2020 21:37:03 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFPK8-00043z-Hg
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 21:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584740219;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=m4umwlXCIziZzrT1zqxkFPMA4KNl2iuJ5/nm8dl4/DU=;
 b=Yeh2WmhtmrhFegh6ighekB1S8cp2uJWDTiOWnIQB/Alxh9xKMG8kuRXyZPQXJkMKMrq78p
 QPdVZt1eS5TQfXrnC4JjvBmxrXYR8USPYBkj7LcSd2AEVxYqPP4PV9+RNDnj4FVtW2bobX
 6Z9zsXjZke56zNupxKXf58jM5LX6Ns4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-YuE0DDjHN1SQCBAxPiHFBQ-1; Fri, 20 Mar 2020 17:36:44 -0400
X-MC-Unique: YuE0DDjHN1SQCBAxPiHFBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B73D801E5C
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 21:36:44 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62F0E1001DF2
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 21:36:43 +0000 (UTC)
To: linux-nvme@lists.infradead.org
From: Tony Asleson <tasleson@redhat.com>
Subject: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Organization: Red Hat
Message-ID: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
Date: Fri, 20 Mar 2020 16:36:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_143700_674632_2B0C4D97 
X-CRM114-Status: UNSURE (   8.97  )
X-CRM114-Notice: Please train this message.
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Using two different VMs with nvme-tcp, I tried to create a fs and it
hung with kernel oops on client VM.

Both client/initiator and server/target are running Fedora 31,
5.5.8-200.fc31.x86_64

Reproduces every time.  I also tried creating a gpt partition table on
it first, which worked.  However, when I tried to create FS it oops'd
again and hanged mkfs command.

Thanks,
-Tony

# cat /etc/nvmet/config.json
{
  "hosts": [
    {
      "nqn":
"nqn.2014-08.org.nvmexpress:uuid:faadcb53-9214-4fbb-a746-7d94c023b53e"
    }
  ],
  "ports": [
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "192.168.2.80",
        "treq": "not specified",
        "trsvcid": "8009",
        "trtype": "tcp"
      },
      "ana_groups": [
        {
          "ana": {
            "state": "optimized"
          },
          "grpid": 1
        }
      ],
      "param": {
        "inline_data_size": "16384"
      },
      "portid": 1,
      "referrals": [],
      "subsystems": []
    }
  ],
  "subsystems": [
    {
      "allowed_hosts": [

"nqn.2014-08.org.nvmexpress:uuid:faadcb53-9214-4fbb-a746-7d94c023b53e"
      ],
      "attr": {
        "allow_any_host": "0",
        "serial": "967af933980faedc",
        "version": "1.3"
      },
      "namespaces": [
        {
          "ana_grpid": 1,
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/sdc",
            "uuid": "c2c140e4-aff2-4df4-8926-1686a485e99d"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn":
"nqn.2014-08.org.nvmexpress:NVMf:uuid:23d9d3e0-a83e-45d7-a902-3e80679385f8"
    }
  ]
}


# mkfs.ext4 /dev/nvme0n1

[  125.031254] nvme-fabrics ctl: Failed to read smart log (error -5)
[  125.031509] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 192.168.2.80:8009
[  125.034133] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  125.246827] nvme nvme0: creating 1 I/O queues.
[  125.249356] nvme nvme0: mapped 1/0/0 default/read/poll queues.
[  125.250788] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress:NVMf:uuid:23d9d3e0-a83e-45d7-a902-3e80679385f8",
addr 192.168.2.80:8009
[  125.257115] nvme0n1: detected capacity change from 0 to 34359738368
[  153.188620] blk_update_request: I/O error, dev nvme0c0n1, sector
67108736 op 0x9:(WRITE_ZEROES) flags 0x5000800 phys_seg 0 prio class 0
[  153.191395] BUG: kernel NULL pointer dereference, address:
0000000000000008
[  153.191440] #PF: supervisor read access in kernel mode
[  153.191468] #PF: error_code(0x0000) - not-present page
[  153.191495] PGD 0 P4D 0
[  153.191513] Oops: 0000 [#1] SMP PTI
[  153.191534] CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted
5.5.9-200.fc31.x86_64 #1
[  153.191574] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  153.191619] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[  153.191660] RIP: 0010:nvme_tcp_io_work+0x303/0x790 [nvme_tcp]
[  153.191692] Code: ff ff 41 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff
ff 49 8b 46 28 48 89 04 24 49 8b 46 78 49 8b 56 68 41 8b 6e 34 41 2b 6e
38 <8b> 58 08 44 8b 60 0c 4c 8b 38 48 29 d3 49 01 d4 48 39 eb 48 0f 47
[  153.191783] RSP: 0018:ffffbc118020fde8 EFLAGS: 00010206
[  153.191810] RAX: 0000000000000000 RBX: 00000000579f5801 RCX:
0000000000000000
[  153.191863] RDX: 0000000000000000 RSI: 0000000000000011 RDI:
ffff9322579f5900
[  153.191907] RBP: 0000000000001000 R08: 0000000000001000 R09:
0000000000000000
[  153.191944] R10: 0000000000000009 R11: 0000000000000000 R12:
ffff932259d90ee0
[  153.191981] R13: 0000000000000048 R14: ffff9322579f58a0 R15:
0000000000000048
[  153.192018] FS:  0000000000000000(0000) GS:ffff93225bc00000(0000)
knlGS:0000000000000000
[  153.192059] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  153.192087] CR2: 0000000000000008 CR3: 0000000116ff2005 CR4:
00000000000606f0
[  153.192126] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  153.192163] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  153.192199] Call Trace:
[  153.192228]  process_one_work+0x1b5/0x360
[  153.192263]  worker_thread+0x50/0x3c0
[  153.192286]  kthread+0xf9/0x130
[  153.192311]  ? process_one_work+0x360/0x360
[  153.192334]  ? kthread_park+0x90/0x90
[  153.192361]  ret_from_fork+0x35/0x40
[  153.192390] Modules linked in: nvme_tcp nvme_fabrics nvme_core rfkill
snd_intel8x0 intel_rapl_msr intel_rapl_common intel_powerclamp
snd_ac97_codec crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
snd_pcsp ac97_bus snd_pcm e1000 snd_timer intel_rapl_perf joydev snd
soundcore i2c_piix4 vboxguest ip_tables xfs libcrc32c vmwgfx
drm_kms_helper ttm drm crc32c_intel serio_raw ata_generic pata_acpi video
[  153.194139] CR2: 0000000000000008
[  153.194619] ---[ end trace 94d1bf7f7728b447 ]---
[  153.195102] RIP: 0010:nvme_tcp_io_work+0x303/0x790 [nvme_tcp]
[  153.195565] Code: ff ff 41 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff
ff 49 8b 46 28 48 89 04 24 49 8b 46 78 49 8b 56 68 41 8b 6e 34 41 2b 6e
38 <8b> 58 08 44 8b 60 0c 4c 8b 38 48 29 d3 49 01 d4 48 39 eb 48 0f 47
[  153.197031] RSP: 0018:ffffbc118020fde8 EFLAGS: 00010206
[  153.197525] RAX: 0000000000000000 RBX: 00000000579f5801 RCX:
0000000000000000
[  153.198026] RDX: 0000000000000000 RSI: 0000000000000011 RDI:
ffff9322579f5900
[  153.198511] RBP: 0000000000001000 R08: 0000000000001000 R09:
0000000000000000
[  153.198997] R10: 0000000000000009 R11: 0000000000000000 R12:
ffff932259d90ee0
[  153.199828] R13: 0000000000000048 R14: ffff9322579f58a0 R15:
0000000000000048
[  153.200406] FS:  0000000000000000(0000) GS:ffff93225bc00000(0000)
knlGS:0000000000000000
[  153.200876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  153.201347] CR2: 0000000000000008 CR3: 0000000116ff2005 CR4:
00000000000606f0
[  153.201816] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  153.202284] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  183.652086] block nvme0n1: no usable path - requeuing I/O


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
