From: kbusch@kernel.org (Keith Busch)
Date: Fri, 24 May 2019 14:44:44 -0600
Subject: [PATCH v2] nvme: fix memory leak for power latency tolerance req
In-Reply-To: <258cd66e-9d54-6e5b-0dd5-9dbf0ba84dd8@grimberg.me>
References: <20190517023007.140656-1-yuyufen@huawei.com>
 <0becf386-c4f5-b0f9-2d5f-84da0e58226c@redhat.com>
 <20190517183614.GB25092@localhost.localdomain>
 <258cd66e-9d54-6e5b-0dd5-9dbf0ba84dd8@grimberg.me>
Message-ID: <20190524204444.GB17321@localhost.localdomain>

On Fri, May 24, 2019@01:20:08AM -0700, Sagi Grimberg wrote:
> 
> > Thanks, applied for 5.2
> 
> This should probably be sent to stable as well...

Want to place bets on if stable-bot auto-selects it? :)

But yes, should apply to 4.14+.
