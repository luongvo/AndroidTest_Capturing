package vn.luongvo.androidtest.capturing;

import android.support.test.espresso.intent.Intents;
import android.support.test.rule.ActivityTestRule;
import android.support.test.runner.AndroidJUnit4;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.assertion.ViewAssertions.matches;
import static android.support.test.espresso.intent.Intents.intended;
import static android.support.test.espresso.intent.matcher.IntentMatchers.hasComponent;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withText;

/**
 * Created by Luong Vo on 2/17/16.
 */
@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    @Rule
    public ActivityTestRule mActivityRule = new ActivityTestRule(MainActivity.class);

    @Test
    public void testUI() {
        onView(withText("TextView")).check(matches(isDisplayed()));
        onView(withText("CheckBox")).check(matches(isDisplayed()));
        onView(withText("Next Screen")).check(matches(isDisplayed()));
    }

    @Test
    public void duplicate1TestUI() {
        testUI();
        testUI();
        testUI();
        testUI();
        testUI();
    }

    @Test
    public void testOpenNextScreen() {
        Intents.init();

        onView(withText("Next Screen")).perform(click());
        intended(hasComponent(NextActivity.class.getName()));

        Intents.release();
    }

}
