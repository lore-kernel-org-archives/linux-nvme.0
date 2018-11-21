From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 14:31:01 -0800
Subject: [PATCH 0/2] nvme-tcp: protection from misbehaving link partners
In-Reply-To: <cover.1542805437.git.mskorzhinskiy@solarflare.com>
References: <cover.1542805437.git.mskorzhinskiy@solarflare.com>
Message-ID: <1400c225-b974-4dbd-4650-bcf4714c71fd@grimberg.me>

Mikhail,

> This patch sequence are about to fix a few minor kernel crashes and memory
> corruptions that was spot on a few stress test runs with misbehvaing link
> partners.
> 
> patches 1-2 prevents these awkward crashes and corruptions

Given that this is on the negative testing and effects the state machine
I prefer that we get the initial version included first and then get
this incremental fix in following rc cycles.
