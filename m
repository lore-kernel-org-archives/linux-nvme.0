From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 24 Mar 2014 02:09:01 -0400
Subject: if  the NVMe driver has been validated on dual-cpu platform
In-Reply-To: <45840288.abae.144f2312ef0.Coremail.liaohengquan1986@163.com>
References: <cover.1390897693.git.agordeev@redhat.com>
 <20140311150841.GA25564@dhcp-26-207.brq.redhat.com>
 <196070e8.d690.144bb7e553f.Coremail.liaohengquan1986@163.com>
 <20140313192045.GD6091@linux.intel.com>
 <785daaf7.5696.144e2af49b0.Coremail.liaohengquan1986@163.com>
 <20140321201109.GC5705@linux.intel.com>
 <45840288.abae.144f2312ef0.Coremail.liaohengquan1986@163.com>
Message-ID: <20140324060901.GA5777@linux.intel.com>

On Mon, Mar 24, 2014@11:45:13AM +0800, liaohengquan1986 wrote:
>                   I want to ask that if  the NVMe driver has been validated on dual-cpu platform?

I've run it on a dual socket platform.  Performance is better if the
application is running on the socket that the card is attached to :-)
