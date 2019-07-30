From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 18:06:35 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
Message-ID: <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>


>> If a controller reset is racing with a namespace revalidation, the
>> revalidation I/O will surely fail, but we should not remove the
> 
> No, there is sync IO request in revalidation, and the sync IO can't be completed
> during resetting.

Why? of course it can. The controller reset is responsible to
quiesce + abort + unquiesce both I/O and admin commands.
