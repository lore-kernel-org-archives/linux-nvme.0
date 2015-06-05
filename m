From: axboe@fb.com (Jens Axboe)
Date: Fri, 5 Jun 2015 11:35:24 -0600
Subject: [PATCHv3] NVMe: Automatic namespace rescan
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CB92E72@fmsmsx104.amr.corp.intel.com>
References: <1433190494-19375-1-git-send-email-keith.busch@intel.com>
 <5571D064.4020405@kernel.dk>
 <B58D82457FDA0744A320A2FC5AC253B93CB92E72@fmsmsx104.amr.corp.intel.com>
Message-ID: <5571DDDC.4010208@fb.com>

On 06/05/2015 11:26 AM, Busch, Keith wrote:
>> Looks good to me. I'll apply this, and then I should also respin the
>> patch to detach namespaces dynamically on top of this.
>
> I missed linking this dependency in my notes:
>
> https://urldefense.proofpoint.com/v1/url?u=http://lists.infradead.org/pipermail/linux-nvme/2015-April/001726.html&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=3JMVyziIyZtZ5cv9eWNLwQ%3D%3D%0A&m=xeqvUGi6GFm9tlp7r6YwpAaIPvEgklWnHDwU6MzXb3c%3D%0A&s=7ca6b60d4ddd07a9aa7db58edd2dbc6926fa64b296a1084596bf7185dcd9caa8

I had not seen that patch, ended up committing an identical one myself.

-- 
Jens Axboe
