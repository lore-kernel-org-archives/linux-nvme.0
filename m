From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 13 Aug 2017 17:01:52 +0300
Subject: nvmet panics during high load
In-Reply-To: <CAF9HSi=CzKixvu_VNB+PbZM_08jPHJ2dZBz77RFUpd6waD=H8Q@mail.gmail.com>
References: <CAF9HSikTcqojqWOx7cjBsv9fLCvbkU_f6-1CgQ16Wpb1f5oQ4g@mail.gmail.com>
 <ee61dc25-bb67-8466-6cc9-d20b4ff0104f@grimberg.me>
 <4d0b76b9-4358-6043-4eba-9d5504ce3a1e@grimberg.me>
 <CAF9HSi=yMpLZZTgbi4XDiZZrrseL6axbw1+e+R6JLdr4EKh1Dw@mail.gmail.com>
 <CAF9HSi=CzKixvu_VNB+PbZM_08jPHJ2dZBz77RFUpd6waD=H8Q@mail.gmail.com>
Message-ID: <cedb98d0-3aea-e229-4f2f-092bbd49f7b2@grimberg.me>


> Sorry for the lack of response. I havn't tested the patch.
> I intended to look into the issue further and suggest a simpler
> solution that simply calculates the maximum queue size correctly but
> simply didn't have the time.

AFAICT there is no maximum calculation, it depends on the congestion
that the target may experience..
