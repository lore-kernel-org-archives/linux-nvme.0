Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69866FD8770
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5E1jnAvRkpbf9bKT7biVSPm7SGFmeN1VqXkjsSOq1o=; b=n91KEO9NmbhrewlLa4rXHVL6jo
	BlAiCoWKf/y292odNykwq+2y5TX9wxq/DQc2QzZSaxIivHSXk8ND2rplvq5i2ixpBEDI8i2VRhwv+
	tf+plxh/iKdtgiN7mUC/ZCjWe6VdsRE8iQ/68Aqd5TfkmXUZF7B+oj41ig7qyIIWnZzpMc9860akr
	ijKP9FTqK//T6FHNhsxiF0mdFnDHUObDiU/HO5d05++WB/+85GnIal0zCOCm0Piip3NmE5OUeV6Dt
	vNrvoOXvzOsA/4Pl1qwN+dEhkzgyEcDhxVK8oszlhmj35nKcdigtYe5NI52Bncch2tjuzWF9nti9O
	DS9Vt8oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2V2r-00000006VpD-3uap;
	Tue, 17 Mar 2026 14:05:17 +0000
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2V2o-00000006Vo4-2Ybb;
	Tue, 17 Mar 2026 14:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZCYrMT1ZxWGNokFK7beSbrH5WTce35wbm3WWH68JE5JCVlIxBHjnjAXvbMmZ7ujN6s4yplILOocTjtAi20LAhluRf1QNTo5/7qre6e6pQVg6HfylUZakl29yvI+j5B11Pu+t0tbac5pO74bZIqrOgDrdmvZCfibX+S/UDb1X2sQFrK4EEMHeIbaMwnB6k5X0gZivmudIf+EyXryFeaEYOOwdNf2zrRxcMQ8Ue8XVFKMiU3CULcKt1+SxmUom7NTiGb+NssbtFsXMYWy3ns+brgMfApo3UD6zJpIQLrDnbCJxDg9vO53F2dd3zyODAqQScmUxD3wzKrJRQdMJZfczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5E1jnAvRkpbf9bKT7biVSPm7SGFmeN1VqXkjsSOq1o=;
 b=r2aRxAoIPwdZJpZfbdPifnyIyB7bJGSOeOkbtOLUAqHKgw1UGT7X+QbpAd7IwXOnUIkQTSqrNmqOPz8oHTBi7L/vIauNESTqa2YdD4BNVEY/3jELMXAQLnk34BtsfjN2l3kDmjk8DIJNnnQyNs987k42yyflBsoevu5UKcSeBkcGDFDGRkFOjJiTSRoNt6acK0wHMP5V/tpNbDBblKq1dffI20M2sFBloVo33p+6yPZ2aEU8LItt2eP891YfWFkNuvaljvRZn3tt+VZA1Ena2vn7CDvcDLOP9jnMHvkGd2pD0NBANr3ktNKOzODTO0G3LNx2+NX+xViSQl/xOBHOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5E1jnAvRkpbf9bKT7biVSPm7SGFmeN1VqXkjsSOq1o=;
 b=CyA9qqqjEGCi7pm/FptW+lPNBoc421LtWAmgvfVsolzjapQdbMUXcDmfj/8qKpkRHFX3t7EZ8bFkTftHmfyaesQS2yqfhq3w+JIg7Ae6wnkUaXvqlY3wOTDmfYLZ5GosC+EtmwBXv1nTeyhLN4wgKBMRKO154CM9EvscupiQrEQ94lGAM70OxdJ9dbq1fW76v069F0g9Scwa1qJXvil6eBqhFnKhIR14tiIS5CLv0GBX89UyJY0vOnUn1X9/FEicqWDmCZDM8Wdu5Pvo8rZANv3OdUhk0RHcwXDRiqBu/7cGJrbfe/DdW8HPTe2B4MQzsnRhjdhyVBti7GhNgSIJaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 14:05:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 14:04:59 +0000
Date: Tue, 17 Mar 2026 10:04:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <ablfi0XHifttil3w@lizhi-Precision-Tower-5810>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
 <aa6pW-zpxnrZnfPn@vaman>
 <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
 <abku9bXxkZWUwOhE@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abku9bXxkZWUwOhE@vaman>
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2e412c-8629-4b48-5687-08de842e2ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|19092799006|52116014|376014|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: FrWoeLlwLu05t9qgSGf2OSe64Qxw9kmUL6RNoD3E/kfi/FxEboXFLEqYBfD9xS8cf4jQmcGlmW/s495L2TnuuuUeTMZOStSRFdOoC8VqvR9p5PW9J6Ik/6doq+wXjspvvzKmvuiAQ2BJu0K8aTcuLR5gLdyqC5cd0RaTc/NnIEgVMkbfU2tr79oLfx6mWVYeVEd2W6y/Cgl2pWcOc+GYGoV7CjKao8pvShMThUUhFISrntLWUJDGxVdNsVBpcSJtkfYydKV5OuVS9RG3kegMJMQyR08BtWKBsBTHhB55FGPgkVr2Qqq1ThQMGJJYoR8wMcxWxDzD7NU+eGU5k2mhnHnv5d0rH9YjGgm3cC5zOPyOo/8i4xKywgi5xuerV2kaEB2MFlTofZQ5VzsYotYkZwGX+Hq5OXJGmlOnmmgc7fcAppVa3ioxZ00FkuAtFwUO6UcpQRS2UMdAl/inir0iaRKdoa4uefWJw+frrLYu5nd9SWirx21umBt9O4a3H0Vc7NqUt96VeQhSEqimG65kFjxF1D2p4oqD9BdhA7CqGhiqHC6VkmyB8Q9PMQp0HZMdHMxHQ0S+rUuogqi5VnmcmA+wYMjQBvGp3WJH8QvfvWe/12VqsLnyTVnx/RaEu96CWIS5D9MaMW3rYGpAQSwLuad0g/n66j5QowPypDtW7i3PLz+UwnN7JdTjSqocphrCgCLc+emTRjY590Sptz2HU3FNC7w6nfSbb1SCub7OgOItf0YbdLuzitxmA3/x+oZjwQe4/puwOfYlZtvEqtgV6OycnMrkgG+Q30dsGvK/iK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(52116014)(376014)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/oKvD+7vTssZw5ZwUx+b7y3WeDl6jWhJedIQG6E1H+SCopGBv0ehZZlzcp0?=
 =?us-ascii?Q?mhEgTGPD56fTu9R814i2YVtPwa/+Df5uvT8+Pz7xi1ppUq8X5Ce7Zs6Ae+Ml?=
 =?us-ascii?Q?fEet36krQrzKY3vizxSkD+V4fUd8yWc7kYNEEdBJq9vU6z0V9cUNHxqJI9ES?=
 =?us-ascii?Q?6xR147oNrF5UzXS2ZD9Zl9KUNOTQX3+POR3vWL6zfa2gYKMdwTRLI/0lW8Pg?=
 =?us-ascii?Q?hPVowSq1lGY3zaVIv0yUwVA+jrzZX+l5WvcBxL6CTIUsD49aqaS2P/Hr+9GT?=
 =?us-ascii?Q?Vc2zRfmGy8b29iRE3Ge3+0vIy7nditd9vwkyApAaebu4PhQG7FmS+9u/c0xX?=
 =?us-ascii?Q?/qKvnK1z5XIqOra2/+8AkIuR0TGS32qvDOLRFJ7PaKNNaGLwotlZ6lyGA4KM?=
 =?us-ascii?Q?pkn6aC86odhRvU1TmusN3HTg5wcDiG+abODfqLSWQuZ8S68CRbzwhUklNOxr?=
 =?us-ascii?Q?086AM0BbuJTS1Fx3IuP/ceKMsJlN0nidObe2zSWiboG/UZkwiTcQ2fOtuOzN?=
 =?us-ascii?Q?kEcH8NNQQxbXVjereuBKC5U5TZtkZ9Yu5R4eXHdQ32y2ZAz0B/e8ykQ2gP1H?=
 =?us-ascii?Q?rCfQX2dpj6djaQyRZbmMXkCYPZmudm/0btXnACIJTgfOW/fceUBo7rpIuGLW?=
 =?us-ascii?Q?U1wIyroOT4Lac7/ElZwaLSoELpl2jdgVRMFC+DWuMt2gK4OAKI/xzpIGfbhB?=
 =?us-ascii?Q?7vK2MPh3YL2e4yTWC68o9vgIfS8VIvMrAmwwUGblP8SCXYpImcVE9dc8YoWZ?=
 =?us-ascii?Q?K7N1g45AVPtmKnimJBVsqv3nk5AREQswSDf+mLUqKx5R7Q2Ct/5FTgZXF7pu?=
 =?us-ascii?Q?QA+BmJgmQkFLMg28RQZtnXbA/JrpDi/9SSTVn5yQ9V0i9dpkXM8J4eyzlNwV?=
 =?us-ascii?Q?XTzftnJ/7bJUOLWUnv/GaP88RfBMKqZLdFsi6+GXVSrtdZHZm06MMY4E0XOX?=
 =?us-ascii?Q?3zR7aU3C7aonk9Tz0BpqhTeIK+6fzKJwtgTVpZtga4xZXxN+HVZWlciHlENz?=
 =?us-ascii?Q?rpQPbXfzeZzzT6gIQjQHo8RMK8Cy+sVwDISGDY1FzfrSeDYu+I8phrVIzB1T?=
 =?us-ascii?Q?yNDRI1nkNVu8KtBnu3qZZhKhwUULB0QKREILBYCANYDo0AvuWGbUskKW1Bgu?=
 =?us-ascii?Q?jlP3+00oFT4A3BJ8Qvx/hIOPoxtqDwGRXmUeLEEeRNPoLEbjMr910gQYuye2?=
 =?us-ascii?Q?iosgOTZftBnolg08KANWV1NqfBhTP9URk2n447Qd57bNJdPVio9bjo78mtMw?=
 =?us-ascii?Q?F3qxGPbIjYC7m2yDSo618sqOslNdUaSQMZPzBp9Lt74NzpnoTXxw0SqboYD0?=
 =?us-ascii?Q?Wrj8UOkvZzLqrzKVmjL3lHCeGXVk5C+NkudLAILMUG2lTz6Gb9+IlVkb234R?=
 =?us-ascii?Q?J5/k47cizOVQG+d1eEGG2t7fXHiCm53twr5jM1X/iZqD9BjdBFppCg1R84Q7?=
 =?us-ascii?Q?VZaW0PYRKWZa25KY0eVCm721PFFt3uxlM9ZXLFLChmYzbLAcFT21OS1lajSk?=
 =?us-ascii?Q?aMHaXH+5pjZytKlAOjUFE1DZdzpuh2+idnZCHU6GUb0L4l06z5kTow4uS17b?=
 =?us-ascii?Q?vmBuQ2kyZZFxx9cw1pfYYIng61qBM+FUnvCBdpYekqvo2qkszy9klQXGbBpA?=
 =?us-ascii?Q?F3x9Zmz82h84Ppx0MA8dej1/chQ7nLAfxcKaZlGj/Z5e6fujFmKSwz87Gtd1?=
 =?us-ascii?Q?eshs9fm9SINgyu56qpbznvj835vkw851NObAQz9ykWR0B1Z6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2e412c-8629-4b48-5687-08de842e2ced
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 14:04:59.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djQIC/EVqri4kl/CpJ/ZA0yraFmki59yiESA+LC58SN6abdB46/QnYPwS8BL18SQH7OTveZdRRzwV3qHnEnQFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_070514_678208_220F6A87 
X-CRM114-Status: GOOD (  31.99  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 17, 2026 at 04:07:41PM +0530, Vinod Koul wrote:
> On 09-03-26, 10:42, Frank Li wrote:
> > On Mon, Mar 09, 2026 at 12:04:59PM +0100, Vinod Koul wrote:
> > > On 18-12-25, 10:56, Frank Li wrote:
> > > > Previously, configuration and preparation required two separate calls. This
> > > > works well when configuration is done only once during initialization.
> > > >
> > > > However, in cases where the burst length or source/destination address must
> > > > be adjusted for each transfer, calling two functions is verbose and
> > > > requires additional locking to ensure both steps complete atomically.
> > > >
> > > > Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> > > > and callback device_prep_config_sg() that combines configuration and
> > > > preparation into a single operation. If the configuration argument is
> > > > passed as NULL, fall back to the existing implementation.
> > > >
> > > > Add a new API dmaengine_prep_config_single_safe() and
> > > > dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> > > > implement callback device_prep_config_sg().
> > >
> > > Okay to add API
> > >
> > > > +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> > > > +		struct dma_chan *chan, struct scatterlist *sgl,
> > > > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > > > +		unsigned long flags, struct dma_slave_config *config,
> > > > +		void *context);
> > >
> > > Do we want to have drivers implement one more callback. It does not make
> > > sense to me. Why not handle this in framework and have it call the
> > > respective lower level APIs.
> >
> > To avoid use addtional lock! suppose each API is re-entriable.
> >
> > thread 1:  call dmaengine_prep_config_sg_safe()
> > thread 2:  call dmaengine_prep_config_sg_safe()
> >
> > If DMA engine driver implement device_prep_config_sg, thread 1 and thread 2
> > can run parallel.
> >
> > If driver have not implement this callback, it have to use mutex make sure
> > config and prep atomic.
> >
> > https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> > show finial opitimziation result, which depend on this. If can't call
> > prep() function parallel, which will kill performace.
>
> Which seems to be 10% in your case.
>
> > > Drivers should implement simple apis and collectively the functionality
> > > can come from the framework.
> > >
> > > Would you consider revising as such. Bonus all existing drivers can
> > > start using this API, no change required for drivers in that case'
> >
> > Not that simple, some devices just call config at probe, especial fix
> > FIFO address and burst length.
> >
> > Call config and prep only need for the case, which need adjust src/dst
> > address, burst length or other parameter for each transfer.
>
> Correct. In the cases where config is done once they can invoke with
> NULL config. I would like the middle layer to handle complexities and
> drivers should be simpler

This patches already implement these.

If you don't like add new callback, how about change existing callback
by add config * and update all drivers.

Frank

>
> >
> > Frank
> >
> > >
> > >
> > > --
> > > ~Vinod
>
> --
> ~Vinod

