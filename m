From: mundu2510@gmail.com (mundu agarwal)
Date: Wed, 16 Jul 2014 11:07:43 +0530
Subject: [PATCH 1/1] NVMe I/O queue depth change to module parameter
In-Reply-To: <20140715182836.GF5855@linux.intel.com>
References: <1405445798-6440-1-git-send-email-mundu2510@gmail.com>
 <20140715182836.GF5855@linux.intel.com>
Message-ID: <CACuVHZn3RtrqUuBcxkh6aA76Ly+ajw9caRo4pf8qq3dRhMKbvw@mail.gmail.com>

Willy,

In one of the server test environment, user unable to change I/O queue
depth more than 1024. Controller supports much higher number but still
limit to 1024.
 Is there any thought for keeping 1024 only ?

Regards,
Mundu

On Tue, Jul 15, 2014@11:58 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
>
> On Tue, Jul 15, 2014@11:06:38PM +0530, Mundu wrote:
> > Signed-off-by: Mundu <mundu2510 at gmail.com>
>
> why?
