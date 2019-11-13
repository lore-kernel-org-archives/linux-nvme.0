Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F56DC432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 23:40:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF55206EC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 23:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SidV2bsm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fnMy2aMD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sk1Ah6kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF55206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wm3hjObUNmgV37bSnPUGH0H5P1hJfG0Ro0B5egM7CGA=; b=SidV2bsmeU1EK2
	MLwU+/jAPgZefM+D5A4Vk3+OS3EHk+WY5WIRhXJnk9ZjYUmIv2r4II/PEUmG1FCq7s6NpS8Y7afGi
	8oSS+qGzOUjpQFPYKN+SRcMBv9NJ7PFymAJ5q5nuPJkZYB6qa2gvjraUJVpM1bYkoEuw04vfOvMve
	i+0rvLyqpPtxLzGe+OpRF7E/S5x7xMf89g7/BFjSkgu3Ma9T94GSFBgGln+dTespAwcOEF0rzX0DM
	sguJl1CYxi1qmyrBNz4PHoCQ6WCxw6EXNazsYMfN5gjWDD9qrpUglN2JXqo7OrLen1eRHi0mPosYx
	A2cy5LypCU9ua9u22jhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV2FB-00077p-Hu; Wed, 13 Nov 2019 23:40:13 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV2F8-00071d-Ti
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 23:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573688410; x=1605224410;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6driPFGpc4IyhXsHpQs7JB9Bbfbqpb9euL+LesJHJDw=;
 b=fnMy2aMDq9DTP+leO5BxgzsXOMQIvq7Glu/bhSiVO7wYaabmgl+Yorb7
 aihXt/s4ShfchSgIGWHgK02QFVTS13RIoIZUjAnxgA+7KQjOytU0pIROX
 5cRKXvVmV5zlpvQWYXJxXts5hqyGqM5RO8gE8URYW6XJb/rZScV0rbnqI
 2x2z75C90fFSdzXkCz6rq08J900qikjTKj5ZMqzpS8uV0pNMGzgbspbTs
 xbVn1gOSXvu3e5gRSf0zhB9tWQ6uy64XFRAd2F1oebojeO9BVp+niWf0o
 OmnQ1JivmIld4dHqGlYQGRD6hTUILY5k6dKABTn6ozuuLt6Wxviull9tT A==;
IronPort-SDR: o8KhJlLYMpDIxVFWo6T/xiPX6Ug1OuyQhmnH5EjLw1nefOoqgqEigOtM47cbSHCtXRdlewUPOj
 64xyKgWbvyMsn5keDw2GYW5Ojpx0/oOnTDZXWmvcA7cy1EplVPJS7M2MlsPO4/MijRzvUBRKg4
 amwW2p+h81M2Q6cR76A2MGjVpGSRSDPmcrrrHCP6Q1U3sU23T4iqNYTj+pWcKhgB5xVpM7u2nJ
 saml5u4IFnHgTJeDEVDA5tsNZ2UPp8vU4jOIvn8MRDmNvftYRlnC9ld0t7azKu/bIm/pt9ldnW
 LLk=
X-IronPort-AV: E=Sophos;i="5.68,302,1569254400"; d="scan'208";a="122950629"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
 by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2019 07:40:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiWmaqecRpiHMdKqNNfkndy6gzwNYd+80UGsjqati1nY5udVJEUrfqy/gSpaIPuP4d2Fm6CzJiKgZVinC8mxSz3OelUww0v5HMBKWlrttG91m1/4OCxHMD6lwxQwNlAObcY/j5fRKDFImHYJUDBSSxBCpku0GXel6YQa8b06RzjjJjJWfF4Bv5s8Zkox1FLUM9rejFj1XodHKi4S6UH8FGnC6irIxIya7kGqaw/nbTfI/MIavdJ/ZsqHqHCQVCgZeMZp3ipqdF8Zxt7LxqEjdJUqfxU6xJ4aKrvliAizjJs8gWbMRK7/PMU2ZHEiKomLmjobBrdVJK0fqiIsmkGY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxm+CgDyq5vDy8YUxf5AKJjaKp2g/iRpCCsmpZIrH6Y=;
 b=QpPoF6xXP5CBes4k20KXdu3bs+U2EgKgpdILoOietFWdLVyC0uab07so3zhuP5JCESKh692zIE+stw72cEWHulk1MKritH3QCKXD0x8mZHkgckawO8dNvAma2Q7QzlZ9p4X3pmaVKe8YTGF69v8iBWz2eZ4qd1mcAN0wJWLOrcGAEqO22oCj2iEso6eJ3aH1v/+qL9CX8pjD1x+F57JYlHJkGSK8E51WPW0f2KP1lPqSx2b8oe71MxlWChXkOajXd7FiCKba6uCnPaORftZNxwDxZ1hPm343RlNFSCmOeK9Xef5ADmSZHbWp3Q6cCQV1m0BJ9a67GVRoAMJN2u6lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxm+CgDyq5vDy8YUxf5AKJjaKp2g/iRpCCsmpZIrH6Y=;
 b=sk1Ah6kPbT8bA7VQwWhaNKHQPrYG1qQyxJ8tr8fl5oHAI2JLvaQTWWhC3xVL7Sr0nflsPJaWNKi+rBSWRhbDO8ucPSW/sShQRBymZhbZgQ/IYFscQx9Oyz37EvVZXA7D4NvO2dbPksglblF6coq7hj0VCJfsXo70CVrRIPiBT1M=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4086.namprd04.prod.outlook.com (52.135.213.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 23:40:08 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 23:40:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Mark Ruijter
 <MRuijter@onestopsystems.com>, James Smart <james.smart@broadcom.com>, Max
 Gurtovoy <maxg@mellanox.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
Thread-Topic: [PATCH] nvmet: make ctrl-id configurable
Thread-Index: AQHVknJzonXLyg8iIUGihKEY8P7NbQ==
Date: Wed, 13 Nov 2019 23:40:08 +0000
Message-ID: <BYAPR04MB5749590C4171F548680DEB7686760@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
 <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
 <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
 <b79e612f-4b49-a80f-bc34-e672ae98c1af@mellanox.com>
 <B500B4ED-DF25-41F3-83F8-6E239718564A@onestopsystems.com>
 <c8472575-1041-c44e-e26a-1201161c22c6@broadcom.com>
 <802cb171-34de-65cc-75c5-83ef7c200dc4@grimberg.me>
 <3D590371-4C4F-4355-B36E-7795FB218FC6@onestopsystems.com>
 <2f3ea2c4-f59a-22e3-ed09-91cf737818ea@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d363b59-5eb6-400c-71d8-08d76892d143
x-ms-traffictypediagnostic: BYAPR04MB4086:
x-microsoft-antispam-prvs: <BYAPR04MB4086AD2C399DBE1BA2F033A386760@BYAPR04MB4086.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(81166006)(186003)(7736002)(446003)(86362001)(81156014)(33656002)(316002)(110136005)(76116006)(5660300002)(74316002)(305945005)(55016002)(52536014)(8936002)(6506007)(6116002)(3846002)(53546011)(76176011)(7696005)(8676002)(229853002)(14444005)(2906002)(9686003)(256004)(66946007)(66556008)(66476007)(64756008)(66446008)(25786009)(26005)(71200400001)(71190400001)(14454004)(66066001)(478600001)(102836004)(486006)(476003)(2501003)(6436002)(6246003)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4086;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnPQVXKIoEJyzA1JjBhEDoIuegaSKbe+jtKXHE6Hbeu65ojr2jN56jeThcA0lUAbXR/hZb2OzwOgklj9Q5W3rMoDw7OaB9J9rtg50A7p+wYJ3PNRZ53B76gqBTm+o+gxFJx+BHnEhkYpasY/QxJh0QYIYq7eaOhYkBljs2+pjy0put8stjMU/VUt5Kb34HENJlqu/PKv9ere1r1KYrIPkUoNoVihB5aNEHjmM08qlxPBe9mh80WTXK/2EoYnASKcgJHu36S6tPAIwSA3o+8HVvEinOFgCRuiYgIzRkGFx75X0R1iTn1rbqV9jHwqetf8eFICN6FmpUFuc0PvNeUXhEj0JqSU2s2ZgbL/nlHc6+PET4sPCull3vQqnnzR+9BB/cyj9ljL4IxLrXSgBfxIgjKl7EfZSMQ0yBTljUSmwjdZQZpkirElwM0A3oJ8rvdn
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d363b59-5eb6-400c-71d8-08d76892d143
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 23:40:08.0297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOjpFFNXk05UqZt7KyGUcGwlM73SnDSF2VJJW8eqsXnVr+ReZiikcMRqpO6LTjQIjwC7Inqo4YjUyBvgACoGemgLGDrmZ9X2DNSpqEaIwvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_154011_085888_AD5B0133 
X-CRM114-Status: GOOD (  11.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/12/2019 11:01 AM, Sagi Grimberg wrote:
>> >root@r11i1:~# nvme list-subsys
>> >nvme-subsys0 - NQN=clvol
>> >\
>> >   +- nvme0 tcp traddr=192.168.1.10 trsvcid=4420
>> >   +- nvme1 tcp traddr=192.168.1.11 trsvcid=4420
>> >
>> >Does this all make sense?
> I think we need a cntlid_max to make sure we don't have collisions..
>
How about following patch which used cntl_min and cntl_max ?

(compile only)

+static bool nvmet_subsys_cntlid_store(struct nvmet_subsys *s, const 
char *page,
+                                     bool min)
+{
+       bool ret = true;
+       u16 cid;
+
+       down_write(&nvmet_config_sem);
+       sscanf(page, "%hu\n", &cid);
+       if (cid <  NVME_CNTLID_MIN || cid > NVME_CNTLID_MAX) {
+               ret = false;
+               goto out;
+       }
+
+       if (min)
+               s->cntlid_min = cid;
+       else
+               s->cntlid_max = cid;
+out:
+       up_write(&nvmet_config_sem);
+
+       return ret;
+}
+
+static bool nvmet_subsys_cntlid_show(struct nvmet_subsys *s, char *page,
+                                    bool min)
+{
+       u16 cid = min ? s->cntlid_min : s->cntlid_max;
+
+       return snprintf(page, PAGE_SIZE, "%u\n", cid);
+}
+
+static ssize_t nvmet_subsys_cntlid_min_show(struct config_item *item,
+                                           char *page)
+{
+       return nvmet_subsys_cntlid_show(to_subsys(item), page, true);
+}
+
+static ssize_t nvmet_subsys_cntlid_min_store(struct config_item *item,
+                                            const char *page, size_t count)
+{
+       struct nvmet_subsys *s = to_subsys(item);
+
+       return nvmet_subsys_cntlid_store(s, page, true) ? count : -EINVAL;
+}
+CONFIGFS_ATTR(nvmet_subsys_, cntlid_min);
+
+static ssize_t nvmet_subsys_cntlid_max_show(struct config_item *item,
+                                           char *page)
+{
+       return nvmet_subsys_cntlid_show(to_subsys(item), page, false);
+}
+
+static ssize_t nvmet_subsys_cntlid_max_store(struct config_item *item,
+                                            const char *page, size_t count)
+{
+       struct nvmet_subsys *s = to_subsys(item);
+
+       return nvmet_subsys_cntlid_store(s, page, false) ? count : -EINVAL;
+}
+CONFIGFS_ATTR(nvmet_subsys_, cntlid_max);
+
  static struct configfs_attribute *nvmet_subsys_attrs[] = {
         &nvmet_subsys_attr_attr_allow_any_host,
         &nvmet_subsys_attr_attr_version,
         &nvmet_subsys_attr_attr_serial,
+       &nvmet_subsys_attr_cntlid_min,
+       &nvmet_subsys_attr_cntlid_max,
         NULL,
  };

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..d5a5af3f21b6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1268,7 +1268,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const 
char *hostnqn,
                 goto out_free_cqs;

         ret = ida_simple_get(&cntlid_ida,
-                            NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+                            subsys->cntlid_min, subsys->cntlid_min,
                              GFP_KERNEL);
         if (ret < 0) {
                 status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
@@ -1416,7 +1416,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char 
*subsysnqn,
                 kfree(subsys);
                 return ERR_PTR(-ENOMEM);
         }
-
+       subsys->cntlid_min = NVME_CNTLID_MIN;
+       subsys->cntlid_max = NVME_CNTLID_MAX;
         kref_init(&subsys->ref);

         mutex_init(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..ecbd16f52973 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -211,6 +211,8 @@ struct nvmet_subsys {
         struct list_head        namespaces;
         unsigned int            nr_namespaces;
         unsigned int            max_nsid;
+       u16                     cntlid_min;
+       u16                     cntlid_max;

         struct list_head        ctrls;

Although we still have the outstanding issue pointed by Mark.
Since we define controller id at the level of subsystem having min and
max still result in the error when we are trying to export same
subsys with two different ports.

Mark please correct me if I'm wrong.

For that case should we use subsys-id + port-id as a combination of the
controller id ?

Any thoughts ?






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
